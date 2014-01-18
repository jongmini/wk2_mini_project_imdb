require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

# headers  = {:accept => "application/json"}
# response = RestClient.get "http://private-5e584-themoviedb.apiary.io/3/configuration", headers
# puts response

# headers  = {:accept => "application/json"}
# response = RestClient.get "http://private-5e584-themoviedb.apiary.io/3/find/{id}", headers
# puts response

# https://api.themoviedb.org/3/movie/550?api_key=2e883d4e1097d6b6bb01747b4ae8df76
# http://docs.themoviedb.apiary.io/#movies

get '/' do  
  # this is the homepage
  html = %q(
  <html><head><title>Movie Search</title></head><body>
  <h1>Find a Movie!</h1>
  <form accept-charset="UTF-8" action="/result" method="post">
    <label for="movie">Search for:</label>
    <input id="movie" name="movie" type="text" /> 
    <input name="commit" type="submit" value="Search" /> 
  </form></body></html>
  )
end

get '/result' do
  search_str = params[:name]
# binding.pry
  # Make a request to the omdb api here!


  response = Typhoeus.get("https://api.themoviedb.org/3/movie/550?api_key=2e883d4e1097d6b6bb01747b4ae8df76/search/movie",:params => {:query => search_val})




  # the original string is {"Search":[{"Title":"The Simpsons Movie","Year":"2007","imdbID":"tt0462538","Type":"movie"},{"Title": etc.

  parsed_str = JSON.parse(response.body)


   # Modify the html output so that a list of movies is provided.
  html_str = "<html><head><title>Movie Search Results</title></head><body><h1>Movie Results</h1>\n<ul>"
  html_str += "<li>#{parsed_str}</li>"
  # stephanie's sort
  # sorted_str = parsed_str["Search"].sort_by{|movie| movie["Year"]}
  # another_list.map <next line>

  # sorted_str.map{|movie| html_str += "<li><a href=poster/#{movie["imdbID"]}>#{movie["Title"]} #{movie["Year"]}</a></li>" }   

  # parsed_str["Search"].map{|movie| html_str += "<li><a href=http://www.imdb.com//title/#{movie["imdbID"]}>#{movie["Title"]} #{movie["Year"]}</a></li>" } 

  html_str += "</ul></body></html>"



end

# smarch25 steve'code
# # create a simple class to store movie title, year, and id
# class Movie
#     attr_accessor :title, :year, :id

#     def initialize(new_title="", new_year="", new_id="")
#       @title = new_title
#       @year = new_year
#       @id = new_id
#     end
# end

# stu's code
# def imdb_pull(search_key, search_val)

#   result = Typhoeus.get("http://www.omdbapi.com/", :params => {search_key => search_val})
#   result = JSON.parse(result.body)
#   result

# end



  # what you put in the serach box get name "movie" then you can call by params[:movie]
  # 3 things need to match action="/result" with '/resut' do
  # method="post" with post '/result' do
  # and "movie" with params[:movie]



  # parsed_str is {"Search"=>[{"Title"=>"The Simpsons Movie", "Year"=>"2007", "imdbID"=>"tt0462538", "Type"=>"movie"}, {"Title"=>"Scary Movie", etc.
# binding.pry

  # steve's code (after creating a class Movie)
  # result_hash["Search"].each { |h| movie_list << Movie.new{h["Title"],h["Year"],h["imdbID"]}}
  # after an instance of the Movie is created, access the title by movie.title, year by movie.year etc.
  # movie_list.sort!{|x,y| x.year <=> y.year}

 

get '/poster/:imdb' do |imdb_id|
  # Make another api call here to get the url of the poster.

  # imdb = params[:movie]

  response = Typhoeus.get("http://www.omdbapi.com", :params => {:i => imdb_id})

  imdb_list = JSON.parse(response.body)


  html_str = "<html><head><title>Movie Poster</title></head><body><h1>Movie Poster</h1>\n"
  html_str += "<h3><img src=#{imdb_list["Poster"]}> </h3>"

  html_str += '<br /><a href="/">New Search</a></body></html>'

end



