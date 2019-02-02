# GraphQL - in order to create link, first sign in
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
# GraphQL: mutation - create link, specify url and description, attached to signed in user
# mutation {
# 	createLink(
# 		url: "http://localhost:3000/graphiql",
# 		description: "Your testing playground",
# 	) {
# 	  id
# 	  url
# 	  description
# 	  postedBy {
# 	    id
# 	    name
# 	  }
# 	}
# }
#
# GraphQL: response data
# {
#   "data": {
#     "createLink": {
#       "id": "1",
#       "url": "http://localhost:3000/graphiql",
#       "description": "Your testing playground",
#       "postedBy": {
#         "id": "1",
#         "name": "Radoslav Stankov"
#       }
#     }
#   }
# }
class Mutations::CreateLink < Mutations::BaseMutation
  null true

  argument :description, String, required: true
  argument :url, String, required: true

  type Types::LinkType

  def resolve(description:, url:)

    link = Link.new(
        description: description,
        url: url,
        user: context[:current_user]
    )

    if link.save
      {
          link: link,
          errors: [],
      }
    else
      {
          link: nil,
          errors: link.errors.full_messages
      }
    end
  end
end
