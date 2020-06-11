require 'rails_helper'

describe 'Show current user request', type: :request do
  let!(:user) { create(:user) }

  let(:request_body) do
    <<~GQL
      query {
        user {
          id
          firstName
          lastName
          email
        }
      }
    GQL
  end

  context 'when the user is logged in' do
    subject(:request) do
      graphql_request(request_body, headers: auth_headers)
    end

    specify do
      request

      expect(response).to have_http_status(:ok)
    end

    specify do
      request

      expect(errors).to be_nil
    end

    it 'returns the current user info' do
      request

      expect(json.dig(:data, :user)).to include_json(
        id: user.id.to_s,
        firstName: user.first_name,
        lastName: user.last_name,
        email: user.email
      )
    end
  end

  context 'when the user is not logged in' do
    subject(:request) do
      graphql_request(request_body)
    end

    it 'does not return an error message' do
      request

      expect(errors).to be_nil
    end

    it 'does not return any data' do
      request

      expect(json.dig(:data, :user)).to be_nil
    end
  end
end
