require 'rails_helper'

describe 'Update user mutation request', type: :request do
  let!(:user) { create(:user) }

  subject(:request) do
    mutation_path(
      :updateUser,
      attributes: attributes,
      return_types: return_types,
      headers: auth_headers
    )
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
      }
    GQL
  end

  let(:response_content) { json[:data][:updateUser] }

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

  context 'with invalid params' do
    let(:updated_user) { user.reload }

    context 'when the email is missing' do
      let(:email) { '' }

      it 'returns an error message' do
        request

        expect(first_error_message).to_not be_nil
      end

      it 'does not update current user' do
        expect {
          request
        }.to_not change{updated_user}
      end
    end

    context 'when the email is taken' do
      let!(:user2) { create(:user, email: 'obikenobi@rebel.com') }

      it 'returns an error message' do
        request

        expect(first_error_message).to_not be_nil
      end

      it 'does not update current user' do
        expect {
          request
        }.to_not change{updated_user}
      end
    end
  end
end
