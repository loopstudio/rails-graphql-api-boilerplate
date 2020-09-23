require 'rails_helper'

describe 'Update user mutation request', type: :request do
  subject(:request) do
    graphql_request(request_body, variables: request_variables, headers: auth_headers)
  end

  let!(:user) { create(:user) }
  let(:first_name) { 'Obi Wan' }
  let(:last_name) { 'Kenobi' }
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }
  let(:request_body) do
    <<~GQL
      mutation UpdateUser(
        $firstName: String,
        $lastName: String,
        $email: String,
        $password: String
      ) {
        updateUser(input: {
          firstName: $firstName,
          lastName: $lastName,
          email: $email,
          password: $password
        }) {
          user {
            id
            firstName
            lastName
            email
          }
        }
      }
    GQL
  end
  let(:request_variables) do
    {
      firstName: first_name,
      lastName: last_name,
      email: email,
      password: password
    }
  end
  let(:response_content) { json.dig(:data, :updateUser) }

  context 'with valid params' do
    let(:updated_user) { user.reload }

    specify do
      request

      expect(errors).to be_nil
    end

    specify do
      request

      expect(response).to have_http_status(:ok)
    end

    it 'updates current user' do
      request

      expect(updated_user.first_name).to eq(first_name)
    end

    it 'returns the user data' do
      request

      expect(response_content[:user]).to include_json(
        id: updated_user.id.to_s,
        firstName: updated_user.first_name,
        lastName: updated_user.last_name,
        email: updated_user.email
      )
    end
  end

  context 'with invalid params' do
    context 'when the email is missing' do
      let(:email) { '' }

      it 'returns an error message' do
        request

        expect(first_error_message).not_to be_nil
      end

      it 'does not update current user' do
        expect {
          request
        }.not_to change(user.reload, :email)
      end
    end

    context 'when the email is taken' do
      before { create(:user, email: email) }

      it 'returns an error message' do
        request

        expect(first_error_message).not_to be_nil
      end

      it 'does not update current user' do
        expect {
          request
        }.not_to change(user.reload, :email)
      end
    end
  end
end
