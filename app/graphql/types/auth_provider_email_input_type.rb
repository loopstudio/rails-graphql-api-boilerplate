module Types
  class AuthProviderEmailInputType < BaseInputObject
    # the name is usually inferred by class name but can be overwritten
    graphql_name 'AUTH_PROVIDER_EMAIL'

    argument :email, String, required: true
    argument :password, String, required: true
  end
end
