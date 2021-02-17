require 'rails_helper'

describe 'Create user mutation request', type: :request do
  let(:request!) do
    mutation_request = <<~GQL
      mutation SignUp(
        $email: String!,
        $password: String!,
        $firstName: String!,
        $lastName: String!
      ) {
        createUser(input: {
          email: $email,
          password: $password,
          firstName: $firstName,
          lastName: $lastName
        }) {
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

    graphql_request(
      mutation_request,
      variables: {
        firstName: 'Obi Wan',
        lastName: 'Kenobi',
        email: email,
        password: password
      }
    )
  end

  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }

  context 'with valid params' do
    let(:created_user) { User.last }
    let(:response_content) { json.dig(:data, :createUser) }

    include_examples 'have http status without errors', :ok

    it 'creates a user', skip_request: true do
      expect { request! }.to change(User, :count).by(1)
    end

    it 'returns the user data' do
      expect(response_content[:user]).to include_json(
        id: created_user.id.to_s,
        firstName: created_user.first_name,
        lastName: created_user.last_name,
        email: created_user.email
      )
    end

    describe 'token' do
      let(:token) { response_content[:token] }

      it { expect(token).not_to be_nil }

      it 'sets the authentication headers' do
        expect(AuthToken.verify(token)).to eq(created_user)
      end
    end
  end

  context 'with invalid params' do
    shared_examples 'returns an error message and does not create a user' do
      it { expect(first_error_message).not_to be_nil }

      specify '', skip_request: true do
        expect { request! }.not_to change(User, :count)
      end
    end

    context 'when the email is missing' do
      let(:email) { '' }

      include_examples 'returns an error message and does not create a user'
    end

    context 'when the password is missing' do
      let(:password) { '' }

      include_examples 'returns an error message and does not create a user'
    end
  end
end
