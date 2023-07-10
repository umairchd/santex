class Mutations::ImportPlayer < Mutations::BaseMutation
  argument :code, String, required: true
  
  type Types::PlayerType
  type Types::CoachType

  field :players, Types::PlayerListType, null: false
  field :coaches, Types::CoachListType, null: false

  def resolve(code:)
    response = FootballApiService.new(code: code).get_players
    competition = Competition.find_by(code: code)
    errors = []
    players = []
    coaches = []
    
    response["teams"].each do |t|
      team = Team.find_by(tla: t["tla"])
      coach = Coach.find_by(name: t["coach"]["name"])
      if coach.nil?
        coach = Coach.new(name: t["coach"]["name"], date_of_birth: t["coach"]["dateOfBirth"], nationality: t["coach"]["nationality"], team_id: team.id)
    
        if coach.save
          coaches << coach
        else
          errors << coach.errors.full_messages
        end
    
        t["squad"].each do |s|
          player = Player.find_by(name: s["name"])
          if player.nil?
            player = Player.new(name: s["name"], position: s["position"], date_of_birth: s["dateOfBirth"], nationality: s["nationality"], team_id: team.id)
    
            if player.save
              players << player
            else
              errors << player.errors.full_messages
            end
          else
            players << player
          end
        end
      else
        coaches << coach
      end
    end
  
    if errors.empty?        
      {   
        coaches: { coaches: coaches },
        players: { players: players }
      }
    else
      {
        success: false,
        errors: errors.flatten
      }
    end
  end   
end