# GraphQL: mutation - create author, specifying name and age
# mutation {
#   createLink(
#     url: "http://npmjs.com/package/graphql-tools",
#     description: "Best tools!",
#   ) {
#     id
#     url
#     description
#   }
# }
#
# GraphQL: response
# {
#   "data": {
#     "createLink": {
#       "id": "3",
#       "url": "http://npmjs.com/package/graphql-tools",
#       "description": "Best tools!"
#     }
#   }
# }
class Mutations::CreateLink < Mutations::BaseMutation
  null true

  argument :description, String, required: true
  argument :url, String, required: true

  type Types::LinkType

  def resolve(description:, url:)
    Link.create!(
        description: description,
        url: url,
        # user: context[:current_user] -> to be replaced with current_user
        )
  end
end
