# repositoire_Sinatra

Ceci est un programme en Ruby

J'ai fait tous les exercises sauf le 2.8 (commenter les potins)

Il permet, grâce à la gem Sinatra de faire fonctionner une application pour créer, consulter et éditer des potins sur serveur local.

Les potins sont sauvegardés sur une base de donnée CSV.

the_gossip_project_sinatra
├── Gemfile
├── Gemfile.lock
├── config.ru
├── db
│   └── gossip.csv
└── lib
    ├── controller.rb
    ├── gossip.rb
    └── views
        ├── index.erb
        |─ new_gossip.erb
        |— show.rb
        |_ edit.rb
