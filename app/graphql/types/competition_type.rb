module Types
  class CompetitionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :code, String
    field :area_name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :teams, [Types::TeamType], null: true

    def teams
      object.teams
    end
  end
end
