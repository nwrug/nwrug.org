Rails.application.routes.draw do
  root 'pages#home'

  get 'up', to: 'rails/health#show'
  get 'code-of-conduct', to: 'pages#code-of-conduct', as: :code_of_conduct
  get 'participate', to: 'pages#participate', as: :participate

  get '/signin', to: 'sessions#new', as: :signin
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: :signout

  # Redirects for all archived event slugs
  get '/events/may11', to: redirect('/events/may-2011-social-meet')
  get '/events/january07', to: redirect('/events/january-2007-what-s-new-in-rails-1-2')
  get '/events/ruby-and-rails-day', to: redirect('/events/september-2006-ruby-and-rails-mini-conference')
  get '/events/june07', to: redirect('/events/june-2007-the-nwrug-way')
  get '/events/16th-february-speedy-tdd-with-rails-the-wrong-way', to: redirect('/events/february-2012-speedy-tdd-with-rails-the-wrong-way')
  get '/events/november08', to: redirect('/events/november-2008-pub-meet-rubyconf-aftermath')
  get '/events/may08', to: redirect('/events/may-2008-just-geeks-in-the-pub-again')
  get '/events/april08', to: redirect('/events/april-2008-just-geeks-in-the-pub')
  get '/events/july10', to: redirect('/events/july-2010-macruby-with-caius-durling')
  get '/events/september10', to: redirect('/events/september-2010-ruby-cloud-infrastructure-heroku')
  get '/events/june08', to: redirect('/events/june-2008-synthesis-connecting-the-dots')
  get '/events/january08', to: redirect('/events/january-2008-building-brightbox')
  get '/events/march09', to: redirect('/events/march-2009-search-in-your-rails-app')
  get '/events/february09', to: redirect('/events/february-2009-nanite-and-an-introduction-to-cloud-computing')
  get '/events/may09', to: redirect('/events/may-2009-going-for-a-ruby')
  get '/events/January09', to: redirect('/events/january-2009-pub-meet-new-years-resolutions')
  get '/events/december08', to: redirect('/events/december-2008-pub-meet-continuing-the-success')
  get '/events/october09', to: redirect('/events/october-2009-uses-and-abuses-of-mocks-and-stubs')
  get '/events/july09', to: redirect('/events/july-2009-source-control-stand-off')
  get '/events/august09', to: redirect('/events/august-2009-capistrano-from-noob-to-winner')
  get '/events/may07', to: redirect('/events/may-2007-unobtrusive-javascript-and-mystery-ruby')
  get '/events/thursday-17th-april-easter-js', to: redirect('/events/april-2014-easter-js')
  get '/events/september09', to: redirect('/events/september-2009-smooth-web-apps-with-varnish')
  get '/events/june10', to: redirect('/events/june-2010-all-things-mongo-with-adam-holt')
  get '/events/may10', to: redirect('/events/may-2010-oauth-and-xauth-with-asa-calow')
  get '/events/april10', to: redirect('/events/april-2010-social-meet')
  get '/events/March10', to: redirect('/events/march-2010-social-meet')
  get '/events/february10', to: redirect('/events/february-2010-hanging-out-at-the-madlab')
  get '/events/november09', to: redirect('/events/november-2009-code-kwoon')
  get '/events/april11', to: redirect('/events/april-2011-making-money-from-your-side-project')
  get '/events/march11', to: redirect('/events/march-2011-social-meetup')
  get '/events/november10', to: redirect('/events/november-2010-nwrug-curry-night')
  get '/events/october10', to: redirect('/events/october-2010-nwrug-curry-night')
  get '/events/august10', to: redirect('/events/august-2010-nwrug-curry-night')
  get '/events/february17', to: redirect('/events/february-2011-introduction-to-pure-data')
  get '/events/january11', to: redirect('/events/january-2011-clojure')
  get '/events/november11', to: redirect('/events/november-2011-the-lightning-round')
  get '/events/June11-meet-engineyard', to: redirect('/events/june-2011-meet-the-engineyard-crew')
  get '/events/september11', to: redirect('/events/september-2011-social-meetup')
  get '/events/july11', to: redirect('/events/july-2011-nwrug-curry-night')
  get '/events/august11', to: redirect('/events/august-2011-the-training-edition')
  get '/events/15th-march-client-side-mvc-an-introduction-to-backbone-js', to: redirect('/events/march-2012-client-side-mvc-an-introduction-to-backbone-js')
  get '/events/19th-january-the-new-year-lightning-round', to: redirect('/events/january-2012-the-new-year-lightning-round')
  get '/events/july12', to: redirect('/events/july-2012-crash-course-in-scala')
  get '/events/june12', to: redirect('/events/june-2012-celluloid-with-adam-holt')
  get '/events/may12', to: redirect('/events/may-2012-the-python-experiment')
  get '/events/16th-april---what-does-this-button-do', to: redirect('/events/april-2015-what-does-this-button-do')
  get '/events/18th-october-rails-4-streaming-with-sawomir-wdwka', to: redirect('/events/october-2012-rails-4-streaming')
  get '/events/20th-december-christmas-social', to: redirect('/events/december-2012-christmas-social')
  get '/events/17th-january---the-hacker-edition', to: redirect('/events/january-2013-the-hacker-edition')
  get '/events/thursday-20th-june-social-meetup', to: redirect('/events/june-2013-social-meetup')
  get '/events/thursday-18th-april---how-to-make-your-objects-selfish-ignorant-and-lazy-in-one-easy-step', to: redirect('/events/april-2013-how-to-make-your-objects-selfish-ignorant-and-lazy-in-one-easy-step')
  get '/events/15th-may---social-meet', to: redirect('/events/may-2014-social-meet')
  get '/events/thursday-20th-february-lightning-talks', to: redirect('/events/february-2014-lightning-talks')
  get '/events/thursday-19th-december---social-meetup', to: redirect('/events/december-2013-social-meetup')
  get '/events/thursday-20th-march-nwrug-social', to: redirect('/events/march-2014-nwrug-social')
  get '/events/thursday-17th-october-improve-your-ruby-code-with-dependency-injection', to: redirect('/events/october-2013-improve-your-ruby-code-with-dependency-injection')
  get '/events/thursday-19th-september-a-very-fast-ruby-on-the-jvm', to: redirect('/events/september-2013-a-very-fast-ruby-on-the-jvm')
  get '/events/15th-january---social-new-years-resolutions', to: redirect('/events/january-2015-social-new-years-resolutions')
  get '/events/18th-september---social-meet', to: redirect('/events/september-2014-social-meet')
  get '/events/21-august---social-meet', to: redirect('/events/august-2014-social-meet')
  get '/events/18th-december---xmas-jumper-party', to: redirect('/events/december-2014-xmas-jumper-party')
  get '/events/2oth-november---the-circuit-breaker-pattern', to: redirect('/events/november-2014-the-circuit-breaker-pattern')
  get '/events/thursday-19th-june---how-basecamp-handled-a-ddos-attack', to: redirect('/events/june-2014-how-basecamp-handled-a-ddos-attack')
  get '/events/thursday-17th-july---a-practical-introduction-to-docker', to: redirect('/events/july-2014-a-practical-introduction-to-docker')
  get '/events/thursday-18th-june---social-meetup', to: redirect('/events/june-2015-social-meetup')
  get '/events/19th-march---the-ruby-code-challenge', to: redirect('/events/march-2015-the-ruby-code-challenge')
  get '/events/thursday-21th-november---messages-queues-for-everyone', to: redirect('/events/november-2013-message-queues-for-everyone')
  get '/events/21st-may---concurrent-ruby', to: redirect('/events/may-2015-concurrent-ruby')
  get '/events/thurs-16th-july---an-intro-to-docker', to: redirect('/events/july-2015-an-intro-to-docker')
  get '/events/19th-feb---making-music-with-ruby', to: redirect('/events/february-2015-making-music-with-ruby')
  get '/events/thursday-18th-july---tdd-and-self-shunt', to: redirect('/events/july-2013-tdd-and-self-shunt')
  get '/events/thursday-16th-may-nils-what-are-your-options', to: redirect('/events/may-2013-nils-what-are-your-options')
  get '/events/march08', to: redirect('/events/march-2008-the-life-of-a-rails-freelancer')
  get '/events/november07', to: redirect('/events/november-2007-the-effects-of-gravity-on-software')
  get '/events/february07', to: redirect('/events/february-2007-rest-women-in-engineering')
  get '/events/january10', to: redirect('/events/january-2010-unix-rediscovering-the-wheel')
  get '/events/june09', to: redirect('/events/june-2009-code-surgery-and-an-introduction-to-zsh')
  get '/events/april09', to: redirect('/events/april-2009-bdd-you-know-you-should-be-doing-it')
  get '/events/december09', to: redirect('/events/december-2009-tokyo-cabinet-and-couch-db')
  get '/events/december11', to: redirect('/events/december-2011-the-nwrug-christmas-special')
  get '/events/october11', to: redirect('/events/october-2011-the-magrails-social')
  get '/events/june11', to: redirect('/events/june-2011-introduction-to-coffeescript')
  get '/events/april12', to: redirect('/events/april-2012-the-lightning-round')
  get '/events/test-driven-puppet-development-by-matt-house', to: redirect('/events/september-2012-test-driven-puppet-development-by-matt-house')
  get '/events/august12', to: redirect('/events/august-2012-an-intro-to-varnish-sponsored-by-creative-lynx')
  get '/events/thursday-20th-august---bug-free-code', to: redirect('/events/august-2015-bug-free-code')
  get '/events/21st-march-bootstrapping-for-developers', to: redirect('/events/march-2013-bootstrapping-for-developers')
  get '/events/15th-november---a-rubyconf-2012-review-with-will-jessop', to: redirect('/events/november-2012-a-rubyconf-2012-review-with-will-jessop')
  get '/events/17th-september---social-meet', to: redirect('/events/september-2015-social-meet')

  resources :events
  resources :quizzes, except: [:index, :destroy]
end
