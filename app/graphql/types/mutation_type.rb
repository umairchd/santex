module Types
  class MutationType < Types::BaseObject
    field :import_league, mutation: Mutations::ImportLeague
    field :create_team, mutation: Mutations::CreateTeam
    field :import_player, mutation: Mutations::ImportPlayer
  end
end
