module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser

    field :create_link, mutation: Mutations::CreateLink
    # field :update_author, mutation: Mutations::UpdateAuthor
    # field :delete_author, mutation: Mutations::DeleteAuthor
  end
end
