require 'rails_helper'

describe 'POST /api/v1/users', type: :request do
  subject(:request) do
    mutation_path(:createUser, attributes: attributes, return_types: return_types)
  end

  let(:first_name) { 'Obi Wan' }
  let(:last_name) { 'Kenobi' }
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }

  let(:response_content) { json[:data][:createUser] }

  let(:attributes) do
    <<~GQL
      {
         firstName: "#{first_name}",
         lastName: "#{last_name}",
         email: "#{email}",
         password: "#{password}"
       }
    GQL
  end

  let(:return_types) do
    <<~GQL
      {
        user {
          id
          firstName
          lastName
          email
        }
        errors
        token
      }
    GQL
  end

  context 'with valid params' do
    let(:created_user) { User.last }

    specify do
      request

      expect(json[:errors]).to_not be
    end

    specify do
      request

      expect(response).to have_http_status(:ok)
    end

    it 'creates a user' do
      expect {
        request
      }.to change(User, :count).by(1)
    end

    it 'returns the user data' do
      request

      expect(response_content[:user]).to include_json(
        id: created_user.id.to_s,
        firstName: created_user.first_name,
        lastName: created_user.last_name,
        email: created_user.email
      )
    end

    it 'sets the authentication headers' do
      request

      token = response_content[:token]
      expect(token).to be
      expect(AuthToken.verify(token)).to eq(created_user)
    end
  end

  context 'with invalid params' do
    context 'when the email is missing' do
      let(:email) { nil }

      it 'returns an error message' do
        request

        expect(response_content[:errors]).to include("Email can't be blank")
      end

      it 'does not create a user' do
        expect {
          request
        }.to_not change(User, :count)
      end
    end

    context 'when the password is missing' do
      let(:password) { nil }

      it 'returns an error message' do
        request

        expect(response_content[:errors]).to include("Password can't be blank")
      end

      it 'does not create a user' do
        expect {
          request
        }.to_not change(User, :count)
      end
    end
  end
end
