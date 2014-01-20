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
  movies = imdb_pull(:s,search_str)

  @movies =[]

  movies["Search"].each { |mov| @movies << [mov["Title"],mov["Year"],mov["imdbID"]] }
  @movies.sort!{|x,y| y[1] <=> x[1]}

  erb :results

end

# the SHOW METHOD/ROUTE for a Movie
get '/movie/:id' do

  imdb_id = params[:id]

  @imdb = imdb_pull(:i,imdb_id)

  erb :show

  end
  