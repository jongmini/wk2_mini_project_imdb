require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

get "/" do
	redirect "/movie"
end


# the INDEX METHOD/ROUTE for a Movie
get "/movie" do

	erb :index

end

def imdb_pull(search_key, search_val)

  result = Typhoeus.get("http://www.omdbapi.com/", :params => {search_key => search_val})
  result = JSON.parse(result.body)
  result

end

# the CREATE METHOD/ROUTE for a Movie
post '/results' do
  search_str = params[:movie]

  @movies = imdb_pull(:s,search_str)
# binding.pry
  
  erb :results
  
    # redirect '/movie/"#{imdbID}"'

end

# the SHOW METHOD/ROUTE for a Movie
# get '/results/show/:imdb' do |imdb_id|
get '/movie/:id' do

  # response = Typhoeus.get("http://www.omdbapi.com", :params => {:i => imdb_id})

  # imdb_list = JSON.parse(response.body)

  imdb_id = params[:id]

  @imdb = imdb_pull(:i,imdb_id)
# binding.pry
  erb :show

 #  @imdb = => {"Title"=>"Hit and Run",
 # "Year"=>"2012",
 # "Rated"=>"R",
 # "Released"=>"22 Aug 2012",
 # "Runtime"=>"100 min",
 # "Genre"=>"Action, Comedy, Romance",
 # "Director"=>"David Palmer, Dax Shepard",
 # "Writer"=>"Dax Shepard",
 # "Actors"=>"Kristen Bell, Dax Shepard, Tom Arnold, Kristin Chenoweth",
 # "Plot"=>
 #  "Former getaway driver Charlie Bronson jeopardizes his Witness Protection Plan identity in order to help his girlfriend get to Los Angeles. The feds and Charlie's former gang chase them on the road.",
 # "Language"=>"English",
 # "Country"=>"USA",
 # "Awards"=>"1 win.",
 # "Poster"=>
 #  "http://ia.media-imdb.com/images/M/MV5BMjExNTgzMTAzMV5BMl5BanBnXkFtZTcwMDA0ODkxOA@@._V1_SX300.jpg",
 # "Metascore"=>"50",
 # "imdbRating"=>"6.1",
 # "imdbVotes"=>"21,316",
 # "imdbID"=>"tt2097307",
 # "Type"=>"movie",
 # "Response"=>"True"}


  # html_str = "<html><head><title>Movie Poster</title></head><body><h1>Movie Poster</h1>\n"
  # html_str += "<h3><img src=#{imdb_list["Poster"]}> </h3>"

  # html_str += '<br /><a href="/">New Search</a></body></html>'

end

