require 'rails_helper'

describe 'Update user mutation request', type: :request do
  let!(:user) { create(:user) }

  subject(:request) do
    mutation_path(:updateUser, attributes: attributes, return_types: return_types, headers: auth_headers)
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
      password: password,
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
      }
    GQL
  end

  let(:response_content) { json[:data][:updateUser] }

  context 'with valid params' do
    let(:updated_user) { User.last }

    specify do
      request

      expect(errors).to be_nil
    end

    specify do
      request

      expect(response).to have_http_status(:ok)
    end

    it 'updates a user' do
      request

      expect(updated_user.first_name).to eq(attributes[:first_name])
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

end
