module Types
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :position, String
    field :date_of_birth, String
    field :nationality, String
    field :team, Types::TeamType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
