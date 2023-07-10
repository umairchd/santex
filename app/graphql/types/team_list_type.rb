module Types
  class TeamListType < Types::BaseObject
    field :teams, [Types::TeamType], null: false
  end
end
  