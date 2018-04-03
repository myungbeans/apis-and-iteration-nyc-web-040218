require 'rest-client'
require 'json'
require 'pry'

def parse_from_api(link)
  all_characters = RestClient.get(link)
  character_hash = JSON.parse(all_characters)
end

def get_character_movies_from_api(character)
  character_hash = parse_from_api('http://www.swapi.co/api/people/')

  films_array = character_hash["results"].map do |character_info|
    if character == character_info["name"]
      character_info["films"]
    end
  end
  return films_array.compact.flatten
end

def parse_character_movies(films_array)
  films_array.map do |film_link|
    puts parse_from_api(film_link)["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?