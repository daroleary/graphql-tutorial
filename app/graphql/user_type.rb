class UserType < GraphQL::Schema::Object
  field :id, ID, null: false
  # field :created_at, DateTimeType, null: false
  field :name, String, null: false
  field :email, String, null: false
  field :votes, [VoteType], null: false
  field :links, [LinkType], null: false
end
