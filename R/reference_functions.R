#' @title Return Vector of Accepted Classes
#'
#' @description Simply returns a vector of classes that `class_block()` accepts currently. Submit an issue on the GitHub repository if you want a class added.
#'
#' @return (character) vector of accepted class names
#'
#' @export
#'
#' @examples
#' # Want to check which classes this package supports?
#' dndR::dnd_classes()
#'
dnd_classes <- function(){

  # Assemble vector of currently supported classes
  current_classes <- c("artificer", "barbarian", "bard", "cleric", "druid",
                       "fighter", "monk", "paladin", "ranger",
                       "rogue", "sorcerer", "warlock", "wizard")

  # Return that vector
  return(current_classes) }


#' @title Return Vector of Supported DnD Races
#'
#' @description Simply returns a vector of races that `race_mods()` accepts currently. Submit an issue on the GitHub repository if you want a race added.
#'
#' @return (character) vector of supported race designations
#'
#' @export
#'
#' @examples
#' # Want to check which races this package supports?
#' dndR::dnd_races()
#'
dnd_races <- function(){

  # Assemble vector of currently supported classes
  current_races <- c(
    "aarakocra", "bugbear", "changeling", "dark elf", "dragonborn", "drow",
    "forest gnome", "goblin", "half elf", "half-elf", "half orc", "half-orc", "high elf",
    "hill dwarf", "hobgoblin", "human", "kalashtar", "lightfoot halfling",
    "mountain dwarf", "orc", "plasmoid", "shifter", "rock gnome", "stout halfling",
    "tiefling", "warforged", "wood elf"
  )

  # Return that vector
  return(current_races) }


#' @title Return Vector of Supported DnD Damage Types
#'
#' @description Simply returns a vector of damage types in DnD
#'
#' @return character vector of damage types
#'
#' @export
#'
#' @examples
#' # Full set of damage types included in DnD Fifth Edition (5e)
#' dndR::dnd_damage_types()
#'
dnd_damage_types <- function(){

  # Assemble vector of currently supported classes
  damages <- c(
    "acid", "bludgeoning", "cold", "fire", "force",
    "lightning", "necrotic", "piercing", "poison",
    "psychic", "radiant", "slashing", "thunder",
    "non-magical damage"
  )

  # Return that vector
  return(damages) }


#' @title Return Vector of Feminine First Names
#'
#' @description Simply returns a vector of feminine first names (in alphabetical order)
#'
#' @return (character) vector of first names
#'
#' @export
#'
#' @examples
#' # Full set of feminine first names
#' dndR::first_names_fem()
#'
first_names_fem <- function(){
  
  # Make vector
  names <- c("Abia", "Abigail", "Abigala", "Abigayl", "Abressa", 
             "Abria", "Abryia", "Abyiga", "Adressa", "Adria",
             "Adryia", "Aebria", "Aedria", "Aelina", "Aelinea", "Aelisabeth", 
             "Aeliya", "Aella", "Aelyssa", "Aemily", "Aemilya", "Aemma", "Aemy", 
             "Aendrea", "Aeobreia", "Aeria", "Aeva", "Aevelyn", "Alaexa", 
             "Aleksa", "Alessa", "Alessana", "Alexa", "Alia", "Alija", "Alina", 
             "Alinea", "Alinia", "Alisann", "Alisea", "Alisia", "Alisja", 
             "Aliss", "Alissa", "Alisya", "Alivia", "Alivya", "Aliya", "Allisann", 
             "Allison", "Allysann", "Allyson", "Alova", "Alya", "Alyce", "Alyna", 
             "Alys", "Alysann", "Alysea", "Alyss", "Alyssia", "Alyxa", "Amee", 
             "Amelia", "Amelya", "Ami", "Amia", "Amilia", "Amilja", "Amja", 
             "Amy", "Amya", "Andrea", "Andreja", "Andreya", "Anika", "Aodreia", 
             "Aria", "Ariana", "Arianna", "Ariel", "Ariella", "Arielle", "Arja", 
             "Arjana", "Arjel", "Arya", "Aryana", "Aryanna", "Aryel", "Aryell", 
             "Aryella", "Ashlena", "Ashlene", "Ashlyne", "Aslena", "Asljena", 
             "Aslyena", "Aubree", "Aubria", "Audree", "Audria", "Aurora", 
             "Ava", "Avaery", "Avelia", "Avelina", "Averee", "Averra", "Avery", 
             "Avia", "Avyrie", "Azalea", "Azelia", "Azlena", "Baella", "Bela", 
             "Bella", "Belle", "Bera", "Betta", "Bree", "Breia", "Brianna", 
             "Brinn", "Brinna", "Brjia", "Brocalina", "Brokalina", "Brooka", 
             "Brooke", "Brooklinea", "Brooklyn", "Bruka", "Bryanna", "Bryia", 
             "Brynn", "Brynna", "Caemila", "Caerlotta", "Calia", "Caliana", 
             "Calla", "Camila", "Camilia", "Carlotta", "Catherina", "Cathryn", 
             "Catrina", "Celine", "Celyne", "Chloe", "Chloeia", "Claira", 
             "Claire", "Clara", "Clayra", "Clayre", "Cloe", "Cloey", "Cloia", 
             "Dalia", "Dalilja", "Dalilya", "Dalyla", "Delia", "Delila", "Delyla", 
             "Dree", "Dreia", "Drjia", "Dryia", "Elia", "Eliana", "Elisabet", 
             "Elisybeth", "Eljana", "Ella", "Elli", "Ellia", "Ellie", "Ellja", 
             "Ellya", "Elva", "Elyana", "Elyna", "Elyssa", "Ema", "Emili", 
             "Emilia", "Emma", "Estelia", "Estella", "Eva", "Evylann", "Evylen", 
             "Faline", "Falinia", "Falyne", "Fanna", "Fantina", "Feria", "Ferjia", 
             "Ferra", "Feryia", "Genaesis", "Genaesys", "Genesia", "Genesys", 
             "Gianesia", "Gianna", "Gina", "Ginna", "Grace", "Graece", "Graja", 
             "Grassa", "Grassia", "Graya", "Grayce", "Grazia", "Haenna", "Halia", 
             "Halie", "Halja", "Halya", "Hanna", "Hannah", "Harper", "Harperia", 
             "Hazel", "Hazelia", "Hazyl", "Iasmina", "Illa", "Imaena", "Imina", 
             "Isabel", "Isabella", "Iveljin", "Janna", "Jasmine", "Jasmyne", 
             "Jazmina", "Jella", "Jemina", "Jenesa", "Jenessa", "Jianna", 
             "Jocelina", "Joceline", "Jocelyn", "Jocelyne", "Joyce", "Kaeli", 
             "Kaelia", "Kaelya", "Kaila", "Kalja", "Kalya", "Kamilia", "Kamilja", 
             "Karlata", "Kathrine", "Kathrinn", "Kathryn", "Kathryne", "Katja", 
             "Katrina", "Katya", "Kayla", "Kima", "Kimbera", "Klara", "Kloja", 
             "Kloya", "Kym", "Kyma", "Kymber", "Laila", "Lailana", "Lana", 
             "Lanja", "Lanna", "Lanya", "Layla", "Laylanna", "Lea", "Leah", 
             "Leena", "Leia", "Leja", "Leya", "Liana", "Lilia", "Lilja", "Lily", 
             "Lilya", "Lina", "Lippi", "Lisabeta", "Lisbeth", "Lona", "Loona", 
             "Luna", "Lyana", "Lylia", "Lyly", "Lyna", "Lysbeth", "Lyssa", 
             "Lyssie", "Madisinia", "Madisyn", "Madizinia", "Madjisa", "Madyisa", 
             "Maedisa", "Maelania", "Maelya", "Maia", "Maja", "Maya", "Mea", 
             "Melania", "Melanja", "Melany", "Melanya", "Mena", "Mia", "Mija", 
             "Mila", "Milae", "Milannia", "Milia", "Milja", "Milly", "Milya", 
             "Mina", "Miya", "Mjila", "Mya", "Myla", "Naome", "Naomi", "Natalia", 
             "Nataliae", "Natalja", "Nataly", "Natalya", "Nathylie", "Natja", 
             "Natta", "Natty", "Natya", "Natylie", "Nicola", "Nicolle", "Nikola", 
             "Nomi", "Nomia", "Nycola", "Nycole", "Oiara", "Ojara", "Olifja", 
             "Olifya", "Olivia", "Olivya", "Olyva", "Ondrea", "Oyara", "Paenelope", 
             "Penelope", "Penny", "Pera", "Peria", "Perja", "Perya", "Pia", 
             "Pinelopi", "Pinna", "Pippi", "Pynelope", "Riana", "Rianna", 
             "Rilia", "Rilie", "Rjanna", "Rjila", "Rubi", "Rubia", "Ruby", 
             "Ryanna", "Ryila", "Ryla", "Rylie", "Samaentha", "Samena", "Samentha", 
             "Samitha", "Samitia", "Samitja", "Samitya", "Samytha", "Sara", 
             "Sarah", "Sarra", "Savanna", "Savannia", "Scarlet", "Scarletta", 
             "Scarlotta", "Selina", "Seline", "Selyne", "Sharla", "Sharlotta", 
             "Sharlotte", "Skarlja", "Skarlya", "Sofi", "Sofia", "Soja", "Sophia", 
             "Sophya", "Sosja", "Sosya", "Soya", "Stella", "Stelly", "Stylla", 
             "Talea", "Talia", "Talya", "Tella", "Thalia", "Tylla", "Uzoia", 
             "Vala", "Valea", "Valentina", "Valentyna", "Valeria", "Valerie", 
             "Valerja", "Valerya", "Valia", "Valja", "Valya", "Vanna", "Victora", 
             "Victoria", "Victorya", "Viktorja", "Viktorya", "Vila", "Vilettia", 
             "Viola", "Violet", "Violetta", "Vittora", "Vittoria", "Vyla", 
             "Ximena", "Yanna", "Yasmine", "Yella", "Yemina", "Yenesa", "Ysabel", 
             "Yvelyn", "Zoe", "Zoea", "Zoeia", "Zoesia", "Zoey", "Zofia", 
             "Zoia", "Zosia", "Zosy", "Zusia")
  
  # Return it
  return(names) }


#' @title Return Vector of Masculine First Names
#'
#' @description Simply returns a vector of masculine first names (in alphabetical order)
#'
#' @return (character) vector of first names
#'
#' @export
#'
#' @examples
#' # Full set of masculine first names
#' dndR::first_names_masc()
#'
first_names_masc <- function(){
  
  # Make vector
  names <- c("Aaro", "Aaron", "Aarus", "Aaryn", "Abbos", "Abel", "Abelan", 
             "Abelus", "Abrahm", "Abram", "Abramo", "Abramus", "Abyl", "Adam", 
             "Adamo", "Adamos", "Adamus", "Adannius", "Adanno", "Adrian", 
             "Adrio", "Adrios", "Adrjan", "Adros", "Adryan", "Adym", "Aedam", 
             "Aedrian", "Aedrio", "Aedyn", "Aeli", "Aelijah", "Aemo", "Aendro", 
             "Aendrus", "Aenglo", "Aenry", "Aethan", "Aethyn", "Aevan", "Aiden", 
             "Aido", "Aidos", "Aidyn", "Aisaac", "Aisiah", "Aksel", "Alaen", 
             "Alecks", "Aleks", "Aleksander", "Alennos", "Aleno", "Alessandro", 
             "Alesso", "Alexander", "Alexandyr", "Alivyr", "Alix", "Alonnos", 
             "Alonso", "Alvan", "Alver", "Alvero", "Alyn", "Alyx", "Andoran", 
             "Andre", "Andrean", "Andrej", "Andrenas", "Andres", "Andrew", 
             "Andrey", "Andro", "Androe", "Andros", "Andrus", "Angel", "Angelo", 
             "Anglo", "Anglos", "Anglus", "Anjel", "Anthony", "Anton", "Antonio", 
             "Antono", "Antony", "Antonyr", "Anyel", "Aro", "Aros", "Asten", 
             "Astin", "Astinus", "Astono", "Astyn", "Athyn", "Axel", "Axelus", 
             "Axlos", "Axyl", "Ayden", "Aydyn", "Bastien", "Bastio", "Bastyen", 
             "Benemo", "Benemos", "Benjamin", "Benjamyn", "Benjamyr", "Benjen", 
             "Benyen", "Bertus", "Braddeus", "Brado", "Bradyn", "Braendyn", 
             "Brahm", "Brahn", "Braidyn", "Bram", "Brammos", "Bran", "Brandjen", 
             "Brando", "Brandyn", "Brannos", "Branus", "Bridos", "Bronn", 
             "Bronnos", "Bruno", "Bryan", "Brydus", "Bryn", "Brynden", "Bryne", 
             "Bryus", "Caeleb", "Caelyb", "Caerlos", "Caertero", "Caleb", 
             "Caliban", "Callos", "Calyb", "Cam", "Camero", "Camerus", "Cameryn", 
             "Camryn", "Carliss", "Carlos", "Carlus", "Carolan", "Cartero", 
             "Cartus", "Cartyr", "Cavo", "Cavos", "Chaerles", "Charlus", "Charly", 
             "Chirles", "Christo", "Christophyr", "Chrystan", "Chrystian", 
             "Chyrles", "Conner", "Connorus", "Connyr", "Conoro", "Cristeno", 
             "Cristenos", "Cristian", "Cristofo", "Cristor", "Cristos", "Crystan", 
             "Daemian", "Daenyel", "Daevo", "Dain", "Dale", "Dalian", "Dalio", 
             "Damien", "Damino", "Damjin", "Dammos", "Damyan", "Damyin", "Damyn", 
             "Dan", "Danello", "Danellos", "Daniel", "Danjel", "Dann", "Dannel", 
             "Dannos", "Danny", "Dano", "Danyel", "Davek", "David", "Davios", 
             "Davo", "Davyd", "Diegon", "Dominac", "Domino", "Domnac", "Domnik", 
             "Domnos", "Dylaen", "Dylan", "Dylus", "Efan", "Efjan", "Efyan", 
             "Egan", "Eli", "Elian", "Elias", "Eligio", "Elihios", "Elijah", 
             "Elijan", "Elio", "Elius", "Eliyan", "Elje", "Ellios", "Ely", 
             "Elyas", "Elye", "Elyjah", "Emannos", "Emanolo", "Emanus", "Emilanus", 
             "Emilian", "Emiljan", "Emilyan", "Emmanus", "Emmon", "Emmyn", 
             "Emynwell", "Enrico", "Enrikos", "Ephanos", "Eric", "Ericus", 
             "Erik", "Eryc", "Eryck", "Eryk", "Esekio", "Esekios", "Esran", 
             "Esro", "Etan", "Ethan", "Ethyn", "Evan", "Evanio", "Evanus", 
             "Evyn", "Ewan", "Ezekio", "Ezekius", "Ezekyel", "Ezran", "Ezro", 
             "Ezros", "Ezrus", "Gabrael", "Gabreal", "Gabreil", "Gabrilo", 
             "Gabrios", "Gabrjel", "Gabryel", "Gaebriel", "Gael", "Gaeus", 
             "Gaevyn", "Gafjen", "Gafyn", "Gail", "Galan", "Gallos", "Gavannos", 
             "Gavano", "Gavin", "Gavyn", "Gayel", "Gayl", "Giaco", "Giacomo", 
             "Giadeo", "Giasson", "Giassonos", "Gionato", "Gionatos", "Giorran", 
             "Gioseno", "Giosenos", "Gioseppi", "Gioseppos", "Giosso", "Giovan", 
             "Giulio", "Goshen", "Goshwa", "Graddos", "Graisen", "Grassio", 
             "Grassos", "Grasyn", "Gray", "Graysen", "Graysus", "Guan", "Guliemo", 
             "Guliemos", "Gwann", "Gwyllam", "Gwyllem", "Haddeo", "Haddeos", 
             "Haddeus", "Hadeos", "Hadrian", "Hadsen", "Haesoe", "Haesus", 
             "Haesys", "Hafjus", "Hafyus", "Han", "Hander", "Handros", "Handus", 
             "Handyr", "Hano", "Hanos", "Hanro", "Hanros", "Hanto", "Hantos", 
             "Hantus", "Harold", "Haroldus", "Haryld", "Hasselo", "Havio", 
             "Havius", "Havy", "Helian", "Helius", "Heljan", "Helyan", "Henrik", 
             "Henro", "Hessos", "Horace", "Horacio", "Horgus", "Horus", "Horyce", 
             "Horys", "Hosea", "Hoseas", "Hosius", "Hossen", "Hosso", "Hossos", 
             "Hudsen", "Hudsyn", "Hulios", "Huntyr", "Hynroe", "Hynrus", "Hynry", 
             "Iacono", "Iaen", "Iago", "Iagos", "Iamos", "Iamus", "Ian", "Ianio", 
             "Ianus", "Iasono", "Ibannos", "Iesso", "Ifjan", "Iono", "Isaac", 
             "Isaak", "Isaias", "Isajas", "Isak", "Isamo", "Isamos", "Isiah", 
             "Isimo", "Isimos", "Isjah", "Ivaen", "Ivan", "Ivano", "Jacob", 
             "Jacoby", "Jacomo", "Jacus", "Jaden", "Jaeck", "Jaecob", "Jaecoby", 
             "Jaeden", "Jaedyn", "Jaeremiah", "Jaeremy", "Jaesen", "Jak", 
             "Jakob", "Jakomos", "Jakonos", "Jakos", "Jaks", "Jaksen", "Jamje", 
             "Jamye", "Jan", "Jannos", "Jarl", "Jasjen", "Jason", "Jasonos", 
             "Jasyn", "Jax", "Jaxon", "Jaxus", "Jaxyn", "Jayden", "Jaymes", 
             "Jeraldo", "Jeremus", "Jesten", "Jestin", "Joathyn", "Joeseph", 
             "Jofan", "Johan", "John", "Johnus", "Jonaeth", "Jonaf", "Jonath", 
             "Jonathyn", "Jonn", "Jonus", "Jorden", "Jordus", "Jordyn", "Joren", 
             "Jorros", "Josaeth", "Josaeus", "Josayah", "Josef", "Josephus", 
             "Joseth", "Joshen", "Joshoe", "Josius", "Josjen", "Josyah", "Jovan", 
             "Jovanus", "Jovos", "Julian", "Juljan", "Julyan", "Julyo", "Jyck", 
             "Kaevin", "Kaliv", "Kamros", "Kamrus", "Kanus", "Karl", "Karlos", 
             "Karlus", "Karolos", "Karros", "Kartus", "Kefjan", "Kefyan", 
             "Kevan", "Kevin", "Kevyn", "Konoros", "Kristjan", "Kristofer", 
             "Kristyan", "Laendus", "Laevi", "Lan", "Landen", "Lando", "Landon", 
             "Landos", "Landyn", "Lebbios", "Lefi", "Lenus", "Leo", "Leon", 
             "Leonaerdo", "Leonnos", "Leonus", "Leonyrdo", "Levi", "Levio", 
             "Levius", "Levy", "Liam", "Liamo", "Liamos", "Lincon", "Lincono", 
             "Linconos", "Linconus", "Lincus", "Linkus", "Linus", "Ljam", 
             "Ljenard", "Ljonus", "Ljuk", "Logaen", "Logan", "Logus", "Lokan", 
             "Louis", "Luc", "Lucae", "Lucaen", "Lucaes", "Lucan", "Lucas", 
             "Lucios", "Lucius", "Lucjius", "Luco", "Lucoe", "Lucos", "Lucus", 
             "Lucyus", "Lugo", "Luho", "Luhos", "Lukas", "Lukios", "Lyam", 
             "Lyenard", "Lynard", "Lynardus", "Lyncon", "Lynkus", "Lyonus", 
             "Lyuk", "Maeson", "Maetho", "Maks", "Maksimos", "Masnos", "Mason", 
             "Masono", "Massimo", "Masyn", "Mateo", "Mateos", "Mathew", "Mathoe", 
             "Matje", "Matjus", "Matos", "Matt", "Matteus", "Mattius", "Matto", 
             "Mattos", "Matye", "Matyus", "Maximer", "Maximo", "Maximus", 
             "Maxus", "Maxymer", "Michael", "Miglan", "Miglos", "Miglus", 
             "Miguel", "Miguelos", "Migwell", "Miliano", "Milio", "Milyannos", 
             "Mither", "Mithrus", "Mitje", "Mitro", "Mitros", "Mitye", "Mychael", 
             "Mygwell", "Mykael", "Mythro", "Naemo", "Naethyn", "Naethynel", 
             "Natan", "Natannos", "Nateo", "Nathan", "Nathanus", "Nathanyel", 
             "Nathyn", "Nathynel", "Natjan", "Natjanus", "Natos", "Natyan", 
             "Natyanus", "Nicholaes", "Nicholus", "Nicholys", "Nicolo", "Nicolus", 
             "Nicos", "Nik", "Nikolas", "Noam", "Nolan", "Nolannos", "Nolano", 
             "Nolanus", "Nolen", "Nolyn", "Nom", "Nycholas", "Oewyn", "Ojin", 
             "Olivus", "Olivyr", "Olliver", "Olver", "Oscar", "Oscaro", "Oscarus", 
             "Osco", "Oscoe", "Oscus", "Oskar", "Oskos", "Otio", "Ottios", 
             "Owen", "Owyn", "Raen", "Remmos", "Remo", "Remus", "Rian", "Riano", 
             "Rianos", "Riddros", "Ridero", "Riderus", "Ridyr", "Rjan", "Robb", 
             "Robbos", "Robero", "Robertus", "Robett", "Robjet", "Robyet", 
             "Roman", "Romannos", "Romanus", "Romen", "Romyn", "Ryan", "Ryder", 
             "Ryderus", "Ryn", "Saccaros", "Saccoro", "Saemuel", "Sammen", 
             "Samos", "Samual", "Samuel", "Samwell", "Santaegus", "Santegus", 
             "Santjeg", "Santo", "Santos", "Santus", "Santyeg", "Sebasten", 
             "Sebastio", "Sebastjan", "Sebastos", "Sebastyan", "Sekjus", "Sekyus", 
             "Siahus", "Skarje", "Skarye", "Stonnos", "Sybasten", "Taegus", 
             "Tago", "Tagos", "Tagus", "Teddus", "Teodoro", "Teodus", "Thaeodore", 
             "Thedoras", "Theodor", "Theodorus", "Theodus", "Thom", "Thomas", 
             "Thomys", "Tiago", "Tiagon", "Tilo", "Tiloros", "Tilus", "Tilyr", 
             "Tofer", "Tomm", "Tommas", "Tommos", "Tommus", "Tomo", "Tomus", 
             "Tophyr", "Tornos", "Ty", "Tyago", "Tyego", "Tylor", "Tylus", 
             "Uenio", "Unnos", "Uwyn", "Victor", "Victoran", "Victorus", "Victyr", 
             "Viktor", "Viktus", "Vincenso", "Vincent", "Vincentus", "Vincenzo", 
             "Vincynt", "Vinkus", "Vinnos", "Vintus", "Vyctor", "Vynce", "Vyncent", 
             "Vyntus", "Wann", "Wanny", "Wilhelm", "Willam", "Willem", "Wjat", 
             "Wyaett", "Wyat", "Wytt", "Wyttus", "Xander", "Xandyr", "Xavios", 
             "Xavius", "Xavy", "Xavyer", "Yaden", "Yago", "Yak", "Yakob", 
             "Yaks", "Yaksen", "Yan", "Yarl", "Yesten", "Yestin", "Yfan", 
             "Ygan", "Yofan", "Yohan", "Yonaf", "Yonnos", "Yoren", "Yosef", 
             "Yoshen", "Yosyen", "Ysaac", "Ysaiah", "Ysak", "Ysiah", "Yulian", 
             "Yvan", "Yzra", "Zachaery", "Zachar", "Zacharus", "Zeckus", "Zeek", 
             "Zeke")
  
  # Return it
  return(names) }


#' @title Return Vector of Surnames
#'
#' @description Simply returns a vector of surnames (a.k.a. last names) in alphabetical order 
#'
#' @return (character) vector of last names
#'
#' @export
#'
#' @examples
#' # Full set of feminine first names
#' dndR::surnames()
#' 
surnames <- function(){
  
  # Make vector
  names <- c("Ackes", "Ailes", "Aler", "Alley", "Allie", "Alteer", "Ankor", 
             "Anvill", "Appler", "Appleyard", "Applin", "Arch", "Bailey", 
             "Bakeler", "Baker", "Ballast", "Bankes", "Banner", "Barnard", 
             "Barnes", "Barr", "Barre", "Baskett", "Bay", "Bayer", "Bayers", 
             "Bayes", "Beacher", "Beecon", "Beeken", "Bell", "Bellows", "Bend", 
             "Berger", "Berriman", "Berry", "Biggs", "Bilder", "Bilds", "Billie", 
             "Birch", "Bird", "Birdett", "Black", "Blackfly", "Blackiron", 
             "Blackscale", "Blacksky", "Blacktide", "Blackwater", "Bloom", 
             "Blue", "Bluffclimber", "Bluffe", "Bobbin", "Bogg", "Boggs", 
             "Boiles", "Bolte", "Bolter", "Bones", "Bootes", "Bowman", "Boyle", 
             "Branch", "Brand", "Brewer", "Bricker", "Bridges", "Brigg", "Briggs", 
             "Bright", "Brightstar", "Brownard", "Browne", "Broyles", "Brush", 
             "Brycks", "Buck", "Builder", "Bulder", "Bull", "Bullyard", "Burgh", 
             "Burns", "Butcher", "Butchett", "Button", "Buttonworth", "Byggs", 
             "Byrch", "Byrd", "Byrdman", "Candler", "Capers", "Capp", "Carpenter", 
             "Carryer", "Carter", "Cartwright", "Cash", "Cast", "Castaway", 
             "Caster", "Chandler", "Chaplain", "Chestnut", "Church", "Churchside", 
             "Clay", "Claymer", "Coaler", "Coates", "Cole", "Coleman", "Colt", 
             "Colter", "Condor", "Cook", "Cooper", "Copper", "Crabb", "Cragg", 
             "Craw", "Cray", "Crest", "Croppe", "Curser", "Dagon", "Darkbrother", 
             "Darker", "Darko", "Darkstar", "Darkwater", "Darryman", "Dayes", 
             "Decker", "Deeken", "Deel", "Deelman", "Deels", "Deere", "Derry", 
             "Diamond", "Diggs", "Doe", "Doones", "Doons", "Dougher", "Dragonfly", 
             "Drake", "Dreamer", "Dredge", "Dredger", "Driver", "Dryver", 
             "Dunne", "Dyer", "Dyeworth", "Ealer", "Eales", "Eddie", "Eeles", 
             "Euler", "Feller", "Felter", "Fielder", "Fields", "Fisher", "Flagg", 
             "Flats", "Fletcher", "Fletchett", "Flowers", "Foote", "Forester", 
             "Forger", "Forrest", "Forrester", "Foxx", "Frey", "Frogg", "Frost", 
             "Fry", "Furrs", "Gardner", "Garner", "Garr", "Glasier", "Glover", 
             "Gold", "Goldsmith", "Goodbrother", "Goodman", "Gray", "Graysky", 
             "Green", "Greene", "Greenscale", "Greentide", "Greentree", "Greenwater", 
             "Greenyard", "Grey", "Greyscale", "Greysteel", "Grillett", "Groveland", 
             "Hall", "Hammett", "Hardison", "Hardy", "Harland", "Harper", 
             "Hatchet", "Hatson", "Hatter", "Hattiman", "Hatty", "Haul", "Hayes", 
             "Hayward", "Heap", "Heckes", "Hecks", "Heights", "Helms", "Hemings", 
             "Hemmings", "Hemson", "Henkeeper", "Hex", "Hides", "Highland", 
             "Hightower", "Hights", "Hill", "Hillclimber", "Hills", "Hites", 
             "Hoar", "Hoard", "Hoardigger", "Holiday", "Holier", "Holliday", 
             "Hollier", "Hollison", "Holly", "Holyday", "Hood", "Hook", "Hooke", 
             "Hopper", "Hord", "Hordegger", "House", "Hunter", "Hurd", "Hyde", 
             "Hydes", "Hylls", "Hylltopper", "Hytes", "Ice", "Icecutter", 
             "Iceland", "Icewind", "Iles", "Innes", "Ironhoof", "Irons", "Ironshoe", 
             "Ironsmith", "Isles", "Jack", "Jewels", "Jewls", "Jules", "Kabbage", 
             "Kast", "Kearse", "Kerse", "Kerser", "Kettle", "Kettleblack", 
             "Kidd", "Kipper", "Kneadler", "Kneadman", "Kopperfield", "Lain", 
             "Laine", "Lander", "Lane", "Lethers", "Lodge", "Longdark", "Longnight", 
             "Lynder", "Mair", "Maker", "March", "Marcher", "Mares", "Marks", 
             "Marsh", "Masen", "Mason", "Mast", "Masyn", "May", "Mayfly", 
             "Mayr", "Meadows", "Mercer", "Millard", "Miller", "Mills", "Mole", 
             "Moler", "Moller", "Molsen", "Molson", "Monnee", "Monny", "Moon", 
             "Moss", "Mosstree", "Munk", "Munnee", "Munny", "Myner", "Mynor", 
             "Needler", "Needleworth", "Neeps", "Norland", "North", "Northland", 
             "Northstar", "Nutt", "Oakes", "Oars", "Oates", "Oredigger", "Ores", 
             "Orr", "Orrdegger", "Orrs", "Orrsen", "Orson", "Overfield", "Overwise", 
             "Oxbow", "Palewine", "Palmer", "Palms", "Pan", "Panning", "Pans", 
             "Park", "Parks", "Peabody", "Peaks", "Peartree", "Pease", "Peeks", 
             "Peers", "Pepper", "Peppers", "Pickens", "Pickes", "Picketts", 
             "Pickler", "Pickles", "Pickman", "Piemaker", "Piers", "Pike", 
             "Pikes", "Pine", "Pines", "Pitch", "Pix", "Plaza", "Poisonweed", 
             "Poisonwood", "Pollin", "Polliwog", "Polly", "Porter", "Porter Redtide", 
             "Pott", "Pottaker", "Potter", "Potts", "Pound", "Poundstone", 
             "Powers", "Preacher", "Preecher", "Preest", "Priest", "Pyckes", 
             "Pyke", "Pykes", "Pyne", "Pynes", "Pytch", "Quicke", "Rainard", 
             "Raines", "Ratt", "Raynes", "Redd", "Redflats", "Redmoon", "Redscale", 
             "Redwine", "Reede", "Reel", "Reelings", "Reines", "Reins", "Reynes", 
             "Reyns", "Rhoads", "Rhodes", "Rich", "Riches", "Richett", "Rider", 
             "Ridge", "Ridgeclimber", "Riggett", "Riggs", "River", "Rivers", 
             "Roades", "Rock", "Rockridge", "Roofe", "Root", "Roote", "Rotten", 
             "Rutland", "Ryde", "Ryder", "Saddler", "Saffron", "Sage", "Sageworthy", 
             "Saint", "Salmon", "Salt", "Salter", "Sandflats", "Sands", "Sawyer", 
             "Sayler", "Scales", "Schipps", "Seabreeze", "Seales", "Seals", 
             "Seams", "Seasalt", "Seemworth", "Shaka", "Shearer", "Shears", 
             "Sheerer", "Sheers", "Shell", "Sheller", "Shelley", "Shellmound", 
             "Shepard", "Shepyrd", "Shields", "Shieldson", "Shine", "Shipps", 
             "Shoals", "Shock", "Shoemaker", "Shore", "Shwimmer", "Silver", 
             "Silverman", "Silvermoon", "Simms", "Singer", "Skeeter", "Skelton", 
             "Skeltyn", "Skito", "Slagg", "Slaughter", "Small", "Smalls", 
             "Smith", "Smittens", "Smitts", "Smitty", "Smoke", "Smyth", "Smythett", 
             "Snow", "Snowes", "Soward", "Sower", "Spade", "Spader", "Spanner", 
             "Spears", "Speers", "Speller", "Spicer", "Springer", "Springs", 
             "Stairs", "Stall", "Staller", "Stallman", "Stalls", "Stallworth", 
             "Star", "Starr", "Steel", "Steele", "Stern", "Sterne", "Stillwater", 
             "Stitches", "Stitchworth", "Stone", "Stoneflats", "Storm", "Storms", 
             "Streams", "Strider", "Stryder", "Summers", "Sunn", "Sunner", 
             "Swift", "Swyft", "Swymmer", "Sylver", "Tanner", "Tarr", "Tate", 
             "Taylor", "Teech", "Teeches", "Theery", "Thick", "Thicke", "Thredd", 
             "Threddaker", "Threddler", "Thresh", "Threshett", "Thyme", "Tidewater", 
             "Tillman", "Tine", "Tinker", "Tinn", "Towers", "Townes", "Towney", 
             "Towns", "Townsend", "Towny", "Trainer", "Trainor", "Trout", 
             "Tudor", "Tuggs", "Tutor", "Tyne", "Tynn", "Underhill", "Underwood", 
             "Vicker", "Vickers", "Vikars", "Vinaker", "Vines", "Vinter", 
             "Vintner", "Vista", "Vykar", "Wackes", "Wahl", "Wahls", "Wain", 
             "Wainwright", "Walker", "Waller", "Walls", "Ware", "Waters", 
             "Watters", "Wax", "Wayne", "Waynwright", "Weaver", "Weever", 
             "Whitard", "White", "Whitesky", "Whitewater", "Whitley", "Whittaker", 
             "Whyte", "Winaker", "Winnows", "Winter", "Wintermoon", "Winters", 
             "Wise", "Wood", "Woode", "Wooden", "Woodhouse", "Woods", "Woodyn", 
             "Woolard", "Woolworth", "Worthy", "Yardley", "Yardly", "Zapp")  
  
  # Return it
  return(names) }
