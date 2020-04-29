require 'rails_helper'

describe 'Sign in user mutation request', type: :request do
  subject(:request) do
    mutation_path(:signInUser, attributes: attributes, return_types: return_types)
  end

  let!(:user) { create(:user, email: email, password: password) }

  let(:email) { 'user@email.com' }
  let(:password) { 'abcd1234' }

  let(:attributes) do
    <<~GQL
      {
        email: "#{email_param}",
        password: "#{password_param}"
      }
    GQL
  end

  let(:email_param) { email }
  let(:password_param) { password }

  let(:return_types) do
    <<~GQL
      {
        user {
          id
          firstName
          lastName
          email
        }
        token
      }
    GQL
  end

  context 'with valid params' do
    let(:response_content) { json[:data][:signInUser] }

    specify do
      request

      expect(json[:errors]).to_not be
    end

    specify do
      request

      expect(response).to have_http_status(:ok)
    end

    it 'does not create a new user' do
      expect {
        request
      }.to_not change(User, :count)
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

    it 'sets the authentication headers' do
      request

      token = response_content[:token]
      expect(token).to be
      expect(AuthToken.verify(token)).to eq(user)
    end
  end

  context 'with invalid params' do
    let(:first_error) { json[:errors].first[:message] }

    shared_examples_for 'does not sign in' do
      it 'returns an error message' do
        request

        expect(first_error).to eq(I18n.t('errors.invalid_credentials'))
      end

      it 'does not create a user' do
        expect {
          request
        }.to_not change(User, :count)
      end

      it { is_expected.to render_error_code(:bad_request) }
    end

    context 'when the email is missing' do
      let(:email_param) { nil }

      it_behaves_like 'does not sign in'
    end

    context 'when the password is missing' do
      let(:password_param) { nil }

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
