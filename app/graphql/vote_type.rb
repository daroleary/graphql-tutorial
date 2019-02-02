class VoteType < GraphQL::Schema::Object
  field :id, ID, null: false
  # field :created_at, DateTimeType, null: false
  field :user, UserType, null: false
  field :link, LinkType, null: false
end
