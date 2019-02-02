module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser

    field :create_link, mutation: Mutations::CreateLink
    field :create_vote, mutation: Mutations::CreateVote
    # field :update_author, mutation: Mutations::UpdateAuthor
    # field :delete_author, mutation: Mutations::DeleteAuthor
  end
end
