class Mutations::ImportLeague < Mutations::BaseMutation
  argument :code, String, required: true
  
  type Types::CompetitionType

  def resolve(code:)
    response = FootballApiService.new(code: code).get_league
    competition = Competition.find_by(code: response["code"])
    unless competition.present?
      competition = Competition.new(name: response["name"], code: response["code"], area_name: response["area"]["name"])
    end
    if competition.save
      {
        id: competition.id,
        name: competition.name
      }
    else
      {
        errors: competition.errors.full_messages
      }
    end
  end
  end