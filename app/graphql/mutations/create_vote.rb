# GraphQL: mutation - create vote, based on linkId ... returning link and user
# mutation {
#   createVote(linkId: "1") {
#     link {
#       description
#     }
#     user {
#       name
#     }
#   }
# }

# GraphQL: response
# {
#   "data": {
#     "createVote": {
#       "link": {
#         "description": "Your testing playground"
#       },
#       "user": {
#         "name": "Radoslav Stankov"
#       }
#     }
#   }
# }
class Mutations::CreateVote < Mutations::BaseMutation
  null true

  argument :link_id, ID, required: false

  type VoteType

  def resolve(link_id:)
    link = Link.find(link_id)
    user = context[:current_user]
    vote = Vote.new(
        # todo: figure out how to get this to work
        # link: GraphqlTutorialSchema.object_from_id(link_id, context),
        link: link,
        user: user
    )

    if vote.save # Successful creation, return the created object with no errors
      {
          link: link,
          user: user,
          errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
          link: nil,
          user: nil,
          errors: vote.errors.full_messages
      }
    end
  end
end

