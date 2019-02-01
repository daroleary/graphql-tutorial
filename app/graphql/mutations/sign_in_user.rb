# GraphQL: mutation - sign in using authentication, returning token and user information
# mutation {
# 	signinUser(
#       email: {
#         email: "rado@example.com",
#         password: "12345"
#       }
# 	) {
# 	  token
#     user {
#       id
#     }
# 	}
# }

#
# GraphQL: response
# {
#   "data": {
#     "signinUser": {
#       "token": "ZWRCVGFqZlBIRG1lNDJYa09BRks5U3Zpb09mWnBaZkptTUFqNVhoWFFQST0tLXZuclRYd0NIeUNOazl6VG51Tkp2WGc9PQ==--2190701147d9b2737c2df4d1bc7bc34edc6ba31c",
#       "user": {
#         "id": "1"
#       }
#     }
#   }
# }
class Mutations::SignInUser < Mutations::BaseMutation
  null true

  argument :email, AuthProviderEmailInput, required: false

  field :token, String, null: true
  field :user, UserType, null: true

  # type UserType

  def resolve(email: nil)
    # basic validation
    return unless email

    user = User.find_by email: email[:email]

    # ensures we have the correct user
    return unless user
    # todo: fix authentication
    # return unless user.authenticate(email[:password])

    # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
    # For Ruby on Rails >=5.2.x use:
    # crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    # todo: use JWT in production
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    context[:session][:token] = token

    { user: user, token: token }
  end
end
