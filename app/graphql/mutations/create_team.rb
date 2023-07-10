class Mutations::CreateTeam < Mutations::BaseMutation
    argument :code, String, required: true
    
    type Types::TeamType

    field :teams, Types::TeamListType, null: false
  
    def resolve(code:)
      response = FootballApiService.new(code: code).get_players
      competition = Competition.find_by(code: code)
      errors = []
      teams = []
    
      response['teams'].each do |t|
        team = Team.find_or_create_by(name: t['name']) do |u|
          u.tla = t['tla']
          u.short_name = t['shortName']
          u.area_name = t['area']['name']
          u.address = t['address']
          u.competition_id = competition.id
        end
    
        if team.errors.any?
          errors << team.errors.full_messages
          next
        end
    
        teams << team
      end
    
      return { success: false, errors: errors.flatten } unless errors.empty?
    
      { teams: { teams: teams } }
    end                      
  end