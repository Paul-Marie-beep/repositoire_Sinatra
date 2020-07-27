require 'gossip' #On appelle le fichier ruby et pas seulement un affichage

class ApplicationController < Sinatra::Base #La classe ApplicationController hérite de Sinatra::Base


  get '/gossips/new/' do #get gère les affichages d'URL
    erb :new_gossip
  end

  post '/gossips/new/'do #post gère ce qui se passe avec le formulaire une fois qu'on a cliqué sur submit
    Gossip.new(params["gossip_author"], params["gossip_content"]).save   #On récupère ce que l'utilisateur rentre dans new_gossip 
    #et on l'injecte dans gossip pour gérer l'interaction avec la BDD. params est un hash {"gossip_author" => XX , "gossip_content" => YY}
    redirect '/' #Ça le renvoie vers la page d'accueil une fois que le potin est soumis 
  end

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
    id = params['id'].to_i #On récupère le numéro du potin que l'on veut et l'on s'assure qu'il s'agit bien d'un entier
    Gossip.find(id)    #On prend la numéro_du_potin_ième ligne du csv. La fonction fin nous revoie un objet gossip dont on peut exploiter les paramètres author et content
    erb :show, locals: { gossip_found: Gossip.find(id)} #On introduit un contante gossip-found que l'on pourra utiliser dans show 
    #et qui renferme l'objet gossip que l'on recherchait
  end

  get '/gossips/:id/edit' do
    erb :edit
  end

  post '/gossips/:id/edit' do  #On rechoppe les données du formulaire de edit.erb
    id = params['id'].to_i
    Gossip.update(id, params["new_gossip_author"], params["new_gossip_content"]) #On active la foncton update dans le fichier gossip.rb
    redirect '/'
     
  end
end
 