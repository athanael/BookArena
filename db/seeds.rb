# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'
require 'open-uri'

puts 'Cleaning database...'
Arena.destroy_all
User.destroy_all

puts 'Creating users...'
bruno = User.create(first_name: "Bruno", last_name: "Coquatrix", email: "b.coquatrix@olympia.fr")
bruno.photo.attach(io: URI.open('https://upload.wikimedia.org/wikipedia/commons/8/85/Identite-Coquatrix-1940-Sacem.png'), filename: 'bruno_coquatrix.png', content_type: 'image/png')
puts "Bruno Coquatrix has been created"
jm = User.create(first_name: "Jean-Marc", last_name: "Dumontet", email: "jmd@jmdprod.fr")
jm.photo.attach(io: URI.open('https://www.francetvinfo.fr/pictures/hIrzUFkX_ZboHpuc0-oEwtKepnA/fit-in/720x/filters:format(avif):quality(50)/2019/04/12/dumontet_1.jpg'), filename: 'jmd.png', content_type: 'image/png')
puts "Jean-Marc has been created"
sae = User.create(first_name: "SAE", last_name: "POPB", email: "SAE-Arena-Paris@paris.fr")
sae.photo.attach(io: URI.open('https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Palais_Omnisports_de_Paris-Bercy_2007.jpg/1920px-Palais_Omnisports_de_Paris-Bercy_2007.jpg'), filename: 'popb.png', content_type: 'image/png')
puts "SAE has been created"

puts 'Creating arenas...'

owner = User.find_by(email: "b.coquatrix@olympia.fr")

olympia = Arena.create(user: owner, name: "Olympia", capacity: 1996, address: "28 Bd des Capucines, 75009 Paris", price: 25599.99, description: "L'Olympia est une salle de spectacle parisienne située dans le 9ᵉ arrondissement de Paris, entre la rue Scribe et la rue Auber. Elle est fondée en 1888 par Joseph Oller et Charles Zidler, les créateurs du Moulin-Rouge. Elle est le plus ancien music-hall de Paris encore en activité.")
olympia.photo.attach(io: URI.open('https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/L%27Olympia_%28Paris%29_en_2010.JPG/1024px-L%27Olympia_%28Paris%29_en_2010.JPG'), filename: 'olympia.png', content_type: 'image/png')
if olympia.persisted?
  puts "Olympia is ready to be rent"
else
  puts "Arena creation failed: #{olympia.errors.full_messages.join(", ")}"
end

owner = User.find_by(email: "jmd@jmdprod.fr")

pointVirgule = Arena.create(user: owner, name: "Le point virgule", capacity: 100, address: "7 Rue Sainte-Croix de la Bretonnerie, 75004 Paris", price: 8000, description: "Le Point-Virgule est une salle de spectacle parisienne située au 7, rue Sainte-Croix-de-la-Bretonnerie, dans le 4ᵉ arrondissement de Paris. Fondée en 1977, elle est l'une des plus anciennes salles de stand-up de la capitale.")
pointVirgule.photo.attach(io: URI.open('https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Point_virgule.jpg/440px-Point_virgule.jpg'), filename: 'lepointvirgule.png', content_type: 'image/png')
if pointVirgule.persisted?
  puts "Le point virgule is ready to be rent"
else
  puts "Arena creation failed: #{pointVirgule.errors.full_messages.join(", ")}"
end

owner = User.find_by(email: "jmd@jmdprod.fr")

grandPointVirgule = Arena.create(user: owner, name: "Le grand point virgule", capacity: 430, address: "8bis Rue de l'Arrivée, 75015 Paris", price: 9999.99, description: "Le Grand Point Virgule est une salle de spectacle parisienne située au 8 bis, rue de l'Arrivée, dans le 15ᵉ arrondissement de Paris. Fondée en 2004, elle est l'une des plus grandes salles de stand-up de la capitale.")
grandPointVirgule.photo.attach(io: URI.open('https://media.abcsalles.com/images/1/salles/1440x960/3967/le-grand-point-virgule.jpg'), filename: 'legrandpointvirgule.png', content_type: 'image/png')
if grandPointVirgule.persisted?
  puts "Le grand point virgule is ready to be rent"
else
  puts "Arena creation failed: #{grandPointVirgule.errors.full_messages.join(", ")}"
end

owner = User.find_by(email: "SAE-Arena-Paris@paris.fr")

popb = Arena.create(user: owner, name: "Bercy Arena", capacity: 15000, address: "8 Bd de Bercy, 75012 Paris", price: 87673, description: "L'Accor Arena, anciennement dénommée Palais omnisports de Paris-Bercy (POPB), est une salle polyvalente située dans le quartier de Bercy, dans le 12ᵉ arrondissement de Paris. Inaugurée en 1984, elle est la plus grande salle polyvalente de France.")
popb.photo.attach(io: URI.open('https://cdn.sortiraparis.com/images/80/97166/724838-champion-des-pistes-des-animations-sportives-gratuites-autour-des-jo-a-tester-a-l-accor-arena.jpg'), filename: 'bercyarena.png', content_type: 'image/png')
if popb.persisted?
  puts "Le popb is ready to be rent"
else
  puts "Arena creation failed: #{popb.errors.full_messages.join(", ")}"
end

puts "Finished! Created #{User.count} users and #{Arena.count} arenas."

User.create(first_name: 'Damien', last_name: 'Merian', category: 'band', email: 'damien@merian.com', password: 'password123')
User.create(first_name: 'Imad', last_name: 'Belhadri', category: 'band', email: 'imad@belhadri.com', password: 'password321')

