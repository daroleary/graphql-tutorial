# GraphQL: mutation - create user, specifying name, authProvider
# mutation {
# 	createUser(
# 	  name: "Radoslav Stankov"
# 	  authProvider: {
# 	    email: {
# 	      email: "rado@example.com",
# 	      password: "123456"
# 	    }
# 	  }
# 	) {
# 	  id
# 	  email
# 	  name
# 	}
# }

#
# GraphQL: response
# {
#   "data": {
#     "createUser": {
#       "id": "1",
#       "email": "rado@example.com",
#       "name": "Radoslav Stankov"
#     }
#   }
# }
class Mutations::CreateUser < Mutations::BaseMutation
  null true

  class AuthProviderSignupData < Types::BaseInputObject
    argument :email, Types::AuthProviderEmailInput, required: false
  end

  argument :name, String, required: true
  argument :auth_provider, AuthProviderSignupData, required: false

  type UserType

  def resolve(name: nil, auth_provider: nil)

    user = User.new(
        name: name,
        email: auth_provider&.[](:email)&.[](:email),
        password: auth_provider&.[](:email)&.[](:password)
    )

    if user.save
      {
          user: user,
          errors: [],
      }
    else
      {
          user: nil,
          errors: user.errors.full_messages
      }
    end
  end
end
