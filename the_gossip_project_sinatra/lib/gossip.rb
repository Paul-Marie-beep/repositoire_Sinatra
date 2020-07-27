require 'csv' #Bien penser à require quand on veut faire du CSV
require 'pry'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content

  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv| #ab, c'est pour être sûr de ne pas écraser le fichier à chaque fois qu'on fait une modif.Là on rajoute un truc à l'existant
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line| #Il se contente se déplacer ligne par ligne dans le CSV  sans le modifier.
      all_gossips << Gossip.new(csv_line[0], csv_line[1]) # Chaque valeur du tableau est un objet Gossip que l'on crée à partir des informations d'une ligne du CSV.
    end
    return all_gossips

  end

  def self.find(id)
    ary = Gossip.all #on range tout le CSV dans un tableau où chaque valeur est un objet gossip
    gossip = ary[id] #On va chopper la n-ième valeur du tableau et on la renvoie
    return gossip
  end

  def self.update(id, author, content) 
    ary = Gossip.all #On crée un tableau avec tous les potins
    gossip = Gossip.new(author, content) #on créé d'un objet potin avec les attributs rentrés dans le fichier edit.erb
    ary.delete_at(id) #On enlève notre potin à éditer du tableau
    ary.insert(id, gossip) #On rajoute le nouveau que l'on vient de créer
    CSV.open('db/gossip.csv', 'w') {|file| file.truncate(0) } #On efface le CSV qu'on a 
    ary.each do |value| #On sauvegarde notre nouveau tableau à la place pour faire un nouveau CSV
      value.save
    end
    
  end

end

