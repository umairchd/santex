require 'httparty'

class FootballApiService
  include HTTParty
  base_uri 'https://api.football-data.org/v4'
  

  def initialize(code:)
    @code = code
    @headers = {
      'X-Auth-Token': 'ebae88162e4e4491ae695b3c0250f561'
    }
  end

  def get_league
    self.class.get("/competitions/#{@code}", headers: @headers)
  end

  def get_players
    self.class.get("/competitions/#{@code}/teams", headers: @headers)
  end
end
