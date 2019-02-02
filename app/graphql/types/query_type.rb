class Types::QueryType < Types::BaseObject
  description "root query"

  field :links, [LinkType], null: false do
    description "gets all links"
  end

  field :all_links, function: Resolvers::LinksSearch

  # GraphQL: query
  # {
  #   links {
  #     url
  #     id
  #     description
  #   }
  # }
  #
  # GraphQL: response
  # {
  #   "data": {
  #     "links": [
  #       {
  #         "url": "http://graphql.org/",
  #         "id": "1",
  #         "description": "The Best Query Language"
  #       },
  #       {
  #         "url": "http://dev.apollodata.com/",
  #         "id": "2",
  #         "description": "Awesome GraphQL Client"
  #       }
  #     ]
  #   }
  # }
  def links
    Link.all
  end
end

