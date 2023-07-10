module Types
  class PlayerListType < Types::BaseObject
    field :players, [Types::PlayerType], null: false
  end
end
