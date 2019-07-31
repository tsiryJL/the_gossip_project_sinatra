require 'sinatra'
$:.unshift File.expand_path("./../lib", __FILE__)
require 'gossip'

class ApplicationController < Sinatra::Base
  attr_accessor :gossip

  get'gossips/:id' do
    erb :index, locals: {gossip: Gossip.find(params[:id])}
  end

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do 
    erb :new_gossip
  end

  post '/gossips/new/' do
    puts "affiche les tableaux csv"
      Gossip.new(params["author"],params["content"]).save
      redirect '/'
  end
  # Edit page for gossips
  get '/gossips/:id/edit/' do |id|
    erb :edit, locals: {id: id, gossip: Gossip.find(id.to_i - 1)}
  end

  # Take into account the edit to the gossip
  post '/gossips/:id/edit/' do |id|
    Gossip.update(id.to_i-1, params['gossip_author'], params['gossip_content'])
redirect "/gossips/#{id}/"

  post '/gossips/new/' do
    puts "Salut, je suis dans le serveur"
    puts "Ceci est le contenu du hash params : #{params}"
    puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["author"]}"
    puts "De la bombe, et du coup ça, ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["content"]}"
    puts "Ça déchire sa mémé, bon allez je m'en vais du serveur, ciao les BGs !"
  end
end

