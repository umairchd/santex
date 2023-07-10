module Types
  class CoachListType < Types::BaseObject
    field :coaches, [Types::CoachType], null: false
  end
end
  