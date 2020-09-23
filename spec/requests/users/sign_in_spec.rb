require 'rails_helper'

describe 'Sign in user mutation request', type: :request do
  subject(:request) do
    graphql_request(request_body, variables: request_variables)
  end

  let!(:user) { create(:user, email: email, password: password) }

  let(:email) { 'user@email.com' }
  let(:password) { 'abcd1234' }

  let(:request_body) do
    <<~GQL
      mutation SignIn($email: String!, $password: String!) {
        signInUser(input: {email: $email, password: $password}) {
          user {
            id
            firstName
            lastName
            email
          }
          token
        }
      }
    GQL
  end

  let(:request_variables) do
    {
      email: email_param,
      password: password_param
    }
  end

  let(:email_param) { email }
  let(:password_param) { password }

  let(:response_content) { json.dig(:data, :signInUser) }

  context 'with valid params' do
    specify do
      request

      expect(errors).to be_nil
    end

    specify do
      request

      expect(response).to have_http_status(:ok)
    end

    it 'does not create a new user' do
      expect {
        request
      }.not_to change(User, :count)
    end

    it 'returns the user data' do
      request

      expect(response_content[:user]).to include_json(
        id: user.id.to_s,
        firstName: user.first_name,
        lastName: user.last_name,
        email: user.email
      )
    end

    specify do
      request

      token = response_content[:token]

      expect(token).not_to be_nil
    end

    it 'sets the authentication headers' do
      request

      token = response_content[:token]

      expect(AuthToken.verify(token)).to eq(user)
    end
  end

  context 'with invalid params' do
    let(:first_error) { errors.first[:message] }

    shared_examples_for 'does not sign in' do
      it 'returns an error message' do
        request

        expect(first_error).to eq(I18n.t('errors.invalid_credentials'))
      end

      it 'does not return the user sign in info' do
        request

        expect(response_content).to be_nil
      end
    end

    context 'when the email is missing' do
      let(:email_param) { '' }

      it_behaves_like 'does not sign in'
    end

    context 'when the password is missing' do
      let(:password_param) { '' }

      it_behaves_like 'does not sign in'
    end

    context 'when the email is not registered' do
      let(:email_param) { 'not@registered.com' }

      it_behaves_like 'does not sign in'
    end

    context 'when the password is invalid for the user' do
      let(:password_param) { 'notHisPassword' }

      it_behaves_like 'does not sign in'
    end
  end
end
