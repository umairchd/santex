module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :competitions,
          [Types::CompetitionType],
          null: false,
          description: "Returns a list of Competitions"

    field :teams,
          [Types::TeamType],
          null: false,
          description: "Returns a list of Teams"
    
    field :players,
          [Types::PlayerType],
          null: false,
          description: "Returns a list of Players"

    field :coach,
          [Types::CoachType],
          null: false,
          description: "Returns a list of Coaches"

    field :league_players, [Types::PlayerType], null: true do
      argument :league_code, String, required: true
      argument :team_name, String, required: false
    end

    field :team_players, [Types::PlayerType], null: true do
      argument :team_name, String, required: false
    end

    def league_players(league_code:, team_name: nil)
      competition = Competition.find_by(code: league_code)
      teams = competition.teams if competition.present?
      teams = teams.where(name: team_name) if team_name.present?
      if competition.present?
        players = competition.teams.map(&:players).flatten
        players
      else
        raise GraphQL::ExecutionError.new('No players present for this league.')
      end
    end

    def team_players(team_name: nil)
      team = Team.find_by(name: team_name)
    
      if team.present?
        if team.players.present?
          players = team.players
        else
          players = [team.coach] if team.coach.present?
        end
      else
        raise GraphQL::ExecutionError.new('Team not found')
      end
    
      players
    end


    def competitions
      Competition.all
    end

    def teams
      Team.all
    end

    def players
      Player.all
    end

    def coach
      Coach.all
    end
  end
end
