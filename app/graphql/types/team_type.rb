module Types
  class TeamType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :tla, String
    field :short_name, String
    field :area_name, String
    field :address, String
    field :coach, Types::CoachType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :players, [Types::PlayerType], null: true

    def players
      object.players
    end
  end
end
