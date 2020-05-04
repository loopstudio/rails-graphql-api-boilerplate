require 'rails_helper'

describe 'Create user mutation request', type: :request do
  subject(:request) do
    mutation_path(:createUser, attributes: attributes, return_types: return_types)
  end

  let(:first_name) { 'Obi Wan' }
  let(:last_name) { 'Kenobi' }
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }

  let(:attributes) do
    {
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password
    }
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
        token
      }
    GQL
  end

  let(:response_content) { json[:data][:createUser] }

  context 'with valid params' do
    let(:created_user) { User.last }

    specify do
      request

      expect(errors).to_not be
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
      expect(token).to_not be_nil
      expect(AuthToken.verify(token)).to eq(created_user)
    end
  end

  context 'with invalid params' do
    context 'when the email is missing' do
      let(:email) { '' }

      it 'returns an error message' do
        request

        expect(first_error_message).to_not be_nil
      end

      it 'does not create a user' do
        expect {
          request
        }.to_not change(User, :count)
      end
    end

    context 'when the password is missing' do
      let(:password) { '' }

      it 'returns an error message' do
        request

        expect(first_error_message).to_not be_nil
      end

      it 'does not create a user' do
        expect {
          request
        }.to_not change(User, :count)
      end
    end
  end
end
