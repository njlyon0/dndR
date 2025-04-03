## ---------------------------------------------------- ##
# NPC Creator Function Upgrade
## ---------------------------------------------------- ##

# Billy (William) Mitchell (https://github.com/wj-mitchell) forked dndR and has been working on some new/upgraded functions
## The coolest / most-easily integratable (IMO) is his upgrades to the `npc_creator` function
## Working here on integrating his version with mine to get that improvement ASAP

## ------------------------------- ##
# Housekeeping ----
## ------------------------------- ##

# Load libraries
librarian::shelf(tidyverse, dndR)

# Clear environment
rm(list = ls()); gc()

## ------------------------------- ##
# Current Function ----
## ------------------------------- ##

# Invoke function to see output
old_out <- dndR::npc_creator(npc_count = 2)

# Check output
old_out
dplyr::glimpse(old_out)

## ------------------------------- ##
# Upgrade Dev Area ----
## ------------------------------- ##

npc_creator <- function(npc_count = 1){
  
  # NPC count must be a single number
  if(is.null(npc_count) || is.numeric(npc_count) != TRUE || length(npc_count) != 1)
    stop("'npc_count' must be specified as a single number")
  
  # Define some vectors of names
  ## Feminine first names ----
  fem_names <- c("Abia", "Abigail", "Abigala", "Abigayl", "Abjiga", "Abressa", 
                 "Abria", "Abrjia", "Abryia", "Abyiga", "Adressa", "Adria", "Adrjia", 
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
  
  ## Masculine first names ----
  masc_names <- c("Aaro", "Aaron", "Aarus", "Aaryn", "Abbos", "Abel", "Abelan", 
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
  
            # Surnames -----
            sur1 <- c("Bright", "Brown", "Browne", "Brushfire", "Camp", "Campman", "Canyon", "Cricketts", "Crickets", "Dunes", "Doons", "Doones", "Dunne", "Dunneman", "Flats", "Fox", "Foxx", "Gold", "Golden", "Grey", "Gray", "Gulch", "Gully", "Hardy", "Hills", "Hill", "Hopper", "Hunter", "Huntsman", "March", "Marcher", "Moon", "Redmoon", "Palmer", "Palms", "Peartree", "Pearman", "Redd", "Red", "Rider", "Ryder", "Rock", "Rockman", "Rock", "Rockman", "Rocker", "Sands", "Scales", "Redscale", "Greyscale", "Singer", "Small", "Smalls", "Star", "Starr", "Stone", "Stoneman", "Storm", "Storms", "Strider", "Stryder", "Sunn", "Sunner", "Tumbleweed", "Walker", "Water", "Watters")
            sur2 <- c("Appletree", "Appler", "Applin", "Barley", "Barleycorn", "Barleywine", "Barns", "Barnes", "Barnard", "Beans", "Beanman", "Beanstalk", "Berry", "Berryland", "Bloom", "Bloomland", "Brown", "Brownland", "Brownard", "Bull", "Bullyard", "Cabbage", "Kabbage", "Cotton", "Cottonseed", "Croppe", "Cropman", "Dairyman", "Darryman", "Darry", "Derry", "Farmer", "Farmor", "Fields", "Fielder", "Fieldman", "Flats", "Redflats", "Sandflats", "Stoneflats", "Flowers", "Gardner", "Gardener", "Gardiner", "Green", "Greene", "Greenland", "Greenyard", "Grove", "Groveland", "Hays", "Hayes", "Hayward", "Henkeeper", "Hennerman", "Herd", "Hurd", "Herdland", "Land", "Lander", "Mares", "Mayr", "Mair", "Meadows", "Milk", "Millet", "Millett", "Mills", "Miller", "Millard", "Neeps", "Neepland", "Nutt", "Nutman", "Oates", "Oats", "Overland", "Overfield", "Peartree", "Pearman", "Pease", "Peapod", "Peabody", "Picket", "Picketts", "Pickens", "Pickman", "Plant", "Planter", "Ploughman", "Plowman", "Plougherman", "Pollen", "Pollin", "Polly", "Pollard", "Rains", "Raines", "Rayns", "Raynes", "Rainard", "Root", "Roote", "Rutland", "Shepherd", "Shepard", "Shepyrd", "Shearer", "Sheerer", "Shears", "Sheers", "Sower", "Soward", "Tate", "Tater", "Thresh", "Threshett", "Tiller", "Tillman", "Vines", "Vineland", "Wheatley", "Wheatly", "Wheat", "Whittaker", "Whitard", "Winnows", "Winnower", "Wool", "Woolard", "Yardly", "Yardley", "Yards")  
            sur3 <- c("Ales", "Aleman", "Aler", "Baker", "Bake", "Bakeler", "Barr", "Barre", "Barman", "Berry", "Berryman", "Berriman", "Boyle", "Boiles", "Boyles", "Brewer", "Brewster", "Broyles", "Broiles", "Broyler", "Butcher", "Butchett", "Cook", "Dice", "Dougherman", "Dougher", "Fry", "Frey", "Fryman", "Gardner", "Gardener", "Gardiner", "Grills", "Grillett", "Innes", "Innman", "Inman", "Kettle", "Kettleblack", "Kettleman", "Kneadler", "Kneadman", "Milk", "Miller", "Mills", "Miller", "Palewine", "Pan", "Pannerman", "Panning", "Peppers", "Pepper", "Pickler", "Pickleman", "Pickles", "Pieman", "Piemaker", "Potts", "Pott", "Potter", "Redwine", "Roasterman", "Salt", "Salter", "Simms", "Simmerman", "Slaughter", "Smoke", "Smoker", "Vines", "Vintner", "Vinaker Winaker", "Wineman")  
            sur4 <- c("Biggs", "Bigg", "Byggs", "Camp", "Campman", "Coates", "Frost", "Furrs", "Furrman", "Graysky", "Whitesky", "Blacksky", "Grey", "Gray", "Hardy", "Hardison", "Hardland", "Harland", "Hills", "Hill", "Hylls", "Hunter", "Huntsman", "Ice", "Iceland", "Icewind", "Icecutter", "Yceland", "Ycewind", "Ycecutter", "Longnight", "Longdark", "Moon", "Wintermoon", "North", "Northman", "Norman", "Northland", "Norland", "Pix", "Pickman", "Pickes", "Pyckes", "Seales", "Seals", "Silver", "Silvermoon", "Sylver", "Snow", "Snowes", "Star", "Starr", "Northstar", "Stone", "Stoneman", "Strider", "Stryder", "Walker", "White", "Whyte", "Winter", "Winters", "Wynters")  
            sur5 <- c("Bobbin", "Bolt", "Bolte", "Bolter", "Button", "Buttonworth", "Capers", "Coates", "Cotton", "Dyer", "Dye", "Dyeworth", "Dyerson", "Dyson", "Felter", "Felterman", "Glover", "Hatter", "Hatty", "Hattiman", "Hatson", "Hemmings", "Hemings", "Hemson", "Hyde", "Hides", "Hydes", "Leathers", "Lethers", "Mercer", "Needleman", "Needler", "Needleworth", "Seams", "Seems", "Seemworth", "Shearer", "Sheerer", "Shears", "Sheers", "Shoemaker", "Stitches", "Stitchworth", "Tailor", "Taylor", "Tanner", "Tannerman", "Thredd", "Threddler", "Threddman", "Threddaker", "Weaver", "Weever", "Wool", "Woolworth", "Yardly", "Yardley", "Yards")  
            sur6 <- c("Bay", "Bayes", "Bayer", "Bayers", "Beacher", "Beach", "Blue", "Bowman", "Castaway", "Crabb", "Crab", "Crest", "Days", "Dayes", "Dunes", "Doons", "Doones", "Dunne", "Dunneman", "Eddy", "Fisher", "Fishman", "Flowers", "Harper", "Hook", "Hooke", "Iles", "Isles", "Ailes", "Mast", "Palmer", "Palms", "Rafman", "Raftman", "Reel", "Reelings", "Salt", "Seasalt", "Sands", "Sandman", "Seabreeze", "Shell", "Shellman", "Shellmound", "Sheller", "Shelley", "Shoals", "Singer", "Star", "Starr", "Stern", "Sterne", "Stillwater", "Storm", "Storms", "Summers", "Sunn", "Sunner", "Swimmer", "Shwimmer", "Swymmer", "Tidewater", "Waters", "Watters", "Waterman")  
            sur7 <- c("Arch", "Archmaker", "Baskett", "Basket", "Bilder", "Builder", "Bulder", "Bilds", "Blow", "Brickman", "Bricker", "Brycks", "Bricks", "Burgh", "Berg", "Burg", "Burgher", "Berger", "Burger", "Carpenter", "Chandler", "Candler", "Clay", "Cooper", "Crafter", "Glass", "Glazier", "Glasier", "Hammer", "Maker", "Mason", "Masen", "Masyn", "Potts", "Pott", "Potter", "Quarrier", "Quarryman", "Rock", "Rockman", "Rocker", "Roof", "Roofe", "Sawyer", "Stone", "Stoneman", "Townes", "Towns", "Towny", "Wahl", "Wall", "Wahls", "Walls", "Waller", "Waxman", "Wax", "Wackes", "Wood", "Woods")
            sur8 <- c("Billy", "Billie", "Bluffe", "Bluffclimber", "Boulder", "Bulder", "Camp", "Campman", "Claymer", "Clayms", "Claimer", "Cole", "Coler", "Coleman", "Coalman", "Coaler", "Coaldigger", "Coledegger", "Condor", "Condorman", "Cragg", "Cragman", "Diggs", "Digger", "Diggman", "Digger", "Diggett", "Dragonhoard", "Dragonhord", "Dragon", "Drake", "Dredge", "Dredger", "Hall", "Haul", "Heights", "Hights", "Hytes", "Hites", "Highland", "Hills", "Hill", "Hillclimber", "Hylltopper", "Hoard", "Hord", "Hoar", "Hoardigger", "Hordegger", "Kidd", "Kipman", "Kipper", "Kipson", "Kopperfield", "Miner", "Myner", "Mynor", "Minor", "Mole", "Moler", "Moller", "Molson", "Molsen", "Ores", "Orr", "Orrs", "Oredigger", "Orrdegger", "Orson", "Orrsen", "Pan", "Pans", "Pannerman", "Panning", "Peaks", "Peeks", "Pike", "Pyke", "Pikeclimber", "Pyketopper", "Pix", "Pickman", "Pickes", "Pyckes", "Pickens", "Quarrier", "Quarryman", "Ridge", "Ridgeclimber", "Ridgetopper", "Rock", "Rockman", "Rocker", "Rockridge", "Snow", "Snowes", "Spade", "Spader Springs", "Springer", "Stone", "Stoneman", "Underhill", "Underwood", "Underman", "Walker")  
            sur9 <- c("Barr", "Barre", "Cash", "Copper", "Coppers", "Curry", "Deals", "Deels", "Deel", "Deelaker", "Deelman. Diamond", "Glass", "Glazier", "Glasier", "Gold", "Golden", "Goldsmith", "Goldman", "Jewels", "Jules", "Jewls", "Lender", "Lenderman", "Lynder", "Mercer", "Money", "Munny", "Monny", "Munnee", "Monnee", "Peppers", "Pepper", "Rich", "Richman", "Richett", "Riches", "Saffron", "Sage", "Salt", "Scales", "Shine", "Ships", "Schipps", "Shipps", "Shipman", "Schippman", "Silver", "Sylver", "Silverman", "Small", "Smalls", "Spicer", "Spiceman", "Star", "Starr", "Thyme", "Ware", "Wool")
            sur10 <- c("Altarside", "Altarworthy", "Beacon", "Beecon", "Beeken", "Bell", "Bolt", "Bolte", "Bolter", "Bones", "Bright", "Burns", "Cast", "Caster", "Kast", "Chaplain", "Chaplin", "Church", "Churchside", "Darko", "Darkstar", "Darker", "Darkbrother", "Deacon", "Deecon", "Deeken", "Drake", "Draco", "Dragon", "Dreamer", "Dreemer", "Dreems", "Goodbrother", "Goodman", "Hecks", "Heckes", "Hex", "Holiday", "Holliday", "Holyday", "Hollier", "Holly", "Holier", "Hollison", "Hood", "Kearse", "Kerse", "Kerser", "Curser", "Monk", "Munk", "Nunn", "Nun", "Powers", "Preacher", "Preecher", "Priest", "Preest", "Sage", "Sageworthy", "Saint", "School", "Skool", "Skolar", "Scholyr", "Shock", "Shocker", "Shaka", "Skelton", "Skeltyn", "Smart", "Spelling", "Speller", "Star", "Starr", "Brightstar", "Teech", "Teeches", "Theery", "Tinker", "Tutor", "Tudor", "Vickers", "Vykar", "Vicker", "Vikars", "Wise", "Overwise", "Worthy", "Zapp", "Zappa")   
            sur11 <- c("Banks", "Bankes", "Bend", "Benderman", "Blue", "Bridges", "Cray", "Craw", "Eddy", "Ferryman", "Ferrimen", "Ferry", "Fisher", "Fishman", "Flowers", "Garr", "Hook", "Hooke", "Hopper", "Iles", "Isles", "Ailes", "Mills", "Miller", "Oars", "Orrs", "Orr", "Oxbow", "Piers", "Peers", "Poleman", "Polman", "Porter", "Rafman", "Raftman", "Reed", "Reede", "Reedy", "Reel", "Reelings", "River", "Rivers", "Salmon", "Shell", "Shellman", "Sheller", "Shelley", "Silver", "Silvermoon", "Small", "Smalls", "Snails", "Snailman", "Spanner", "Stillwater", "Streams", "Streems", "Swimmer", "Shwimmer", "Swymmer", "Trout", "Waters", "Watters", "Waterman", "Whitewater", "Wurms", "Worms")
            sur12 <- c("Anchor", "Ankor", "Anker", "Ballast", "Bay", "Bayes", "Bayer", "Bayers", "Beacon", "Biggs", "Bigg", "Brigg", "Briggs", "Bowman", "Capp", "Capman", "Castaway", "Crabb", "Crab", "Crabber", "Crabman", "Crest", "Darkwater", "Decks", "Decker", "Eddy", "Ferryman", "Ferrimen", "Ferry", "Fisher", "Fishman", "Hardy", "Hardison", "Harper", "Helms", "Helmsman", "Hook", "Hooke", "Iles", "Isles", "Ailes", "Mast", "Oars", "Orrs", "Orr", "Piers", "Peers", "Pitch", "Pytch", "Porter Redtide", "Blacktide", "Riggs", "Riggett", "Sailor", "Saylor", "Sailer", "Sayler", "Salt", "Seasalt", "Saltman", "Seabreeze", "Seaman", "Season", "Seeman", "Ships", "Schipps", "Shipps", "Shipman", "Schippman", "Shore", "Shoreman", "Singer", "Star", "Starr", "Stern", "Sterne", "Storm", "Storms", "Swimmer", "Shwimmer", "Swymmer", "Tar", "Tarr", "Tidewater", "Tuggs", "Tugman", "Waters", "Watters", "Waterman", "Whitewater")
            sur13 <- c("Anvill", "Anvilson", "Bellows", "Black", "Blackiron", "Copper", "Coppers", "Farrier", "Fletcher", "Fletchett", "Forger", "Forgeman", "Goldsmith", "Grey", "Greysteel", "Hammer", "Hammett", "Irons", "Yrons", "Ironsmith", "Ironshoe", "Ironhoof", "Kettle", "Kettleblack", "Kettleman", "Potts", "Pott", "Pottaker", "Pound", "Poundstone", "Shields", "Shieldson", "Slagg", "Slagman", "Smith", "Smyth", "Smitts", "Smittens", "Smitty", "Smythett", "Smoke", "Smoker", "Steel", "Steele", "Steelman", "Swords", "Swordson", "Tinn", "Tinman", "Tynn", "Tyne", "Tine")
            sur14 <- c("Ackes", "Ax", "Archer", "Bailey", "Banner", "Bannerman", "Bay", "Bayes", "Bones", "Boots", "Bootes", "Bowman", "Chestnut", "Colt", "Colter", "Dice", "Dyce", "Dycen", "Dyson", "Flagg", "Flag", "Helms", "Hightower", "Knight", "Leathers", "Lethers", "March", "Marcher", "Mares", "Mayr", "Mair", "Marks", "Mercer", "Pike", "Pikes", "Pyke", "Pykes", "Pikeman", "Pykeman", "Poleman", "Polman", "Rider", "Ryder", "Shields", "Shieldson", "Slaughter", "Spears", "Speers", "Swords", "Swordson", "Towers", "Wahl", "Wall", "Wahls", "Walls", "Waller")
            sur15 <- c("Bay", "Bayes", "Brand", "Carrier", "Carryer", "Carter", "Carton", "Cartwright", "Chestnut", "Colt", "Colter", "Driver", "Dryver", "Foote", "Handler", "Mares", "Mayr", "Mair", "Porter", "Quicke", "Quick", "Reines", "Reynes", "Reins", "Reyns", "Rider", "Ryder", "Ryde", "Saddler", "Stall", "Stalls", "Staller", "Stallworth", "Stallman", "Swift", "Swyft", "Trainor", "Trainer", "Wain", "Wayne", "Wayn", "Wainwright", "Waynwright")
            sur16 <- c("Banks", "Bankes", "Black", "Blacktide", "Greentide", "Boggs", "Bogg", "Bogs", "Bull", "Buzzfly", "Blackfly", "Shoefly", "Cray", "Craw", "Cricketts", "Crickets", "Darkwater", "Dragonfly", "Dragon", "Eeler", "Ealer", "Eeles", "Eales", "Fisher", "Fishman", "Frogg", "Frogman", "Green", "Greene", "Greenwater", "Blackwater", "Grey", "Gray", "Grove", "Groves", "Hook", "Hooke", "Hopper", "Marsh", "Mayfly", "May", "Moss", "Mosstree", "Greentree", "Poisonweed", "Poisonwood", "Polly", "Pollywog", "Polliwog", "Rafman", "Raftman", "Ratt", "Ratman", "Reed", "Reede", "Reedy", "River", "Rivers", "Rotten", "Rotman", "Scales", "Greenscale", "Blackscale", "Shell", "Shellman", "Sheller", "Shelley", "Skeeter", "Skito", "Small", "Smalls", "Snails", "Snailman", "Stillwater", "Swimmer", "Shwimmer", "Swymmer", "Thick", "Thicke", "Tidewater", "Vines", "Waters", "Watters", "Wurms", "Worms")
            sur17 <- c("Alley", "Allie", "Bailey", "Bell", "Berg", "Berger", "Burg", "Burger", "Brickman", "Brickhouse", "Bridges", "Court", "Gardner", "Gardiner", "Hall", "Heap", "Hightower", "Hood", "House", "Lane", "Lain", "Laine", "Lodge", "Lodges", "Park", "Parks", "Plaza", "Rhoads", "Rhodes", "Roades", "Roof", "Spanner", "Stairs", "Street", "Streets", "Towers", "Towns", "Townsend", "Townes", "Towny", "Towney", "Vista", "Wall", "Wahl", "Woodhouse")
            sur18 <- c("Ackes", "Ax", "Archer", "Berry", "Biggs", "Bigg", "Birch", "Byrch", "Bird", "Byrd", "Birdett", "Byrdman", "Bloom", "Bowman", "Branch", "Brush", "Buck", "Deere", "Deerman", "Doe", "Feller", "Fletcher", "Flowers", "Forester", "Forrester", "Forrest", "Fox", "Foxx", "Gardner", "Gardener", "Gardiner", "Green", "Greene", "Grove", "Groves", "Harper", "Hatchet", "Hunter", "Huntsman", "Hyde", "Hides", "Hydes", "Jack", "Lodge", "Lodges", "Meadows", "Mole", "Moler", "Moller", "Moss", "Mosstree", "Greentree", "Oaks", "Oakes", "Pine", "Pines", "Pyne", "Pynes", "Sawyer", "Silver", "Silvermoon", "Singer", "Springs", "Springer", "Strider", "Stryder", "Tanner", "Tannerman", "Thick", "Thicke", "Walker", "Woods", "Wood", "Woode", "Wooden", "Woodyn")
  
  # Make sure count is an integer
  npc_count <- round(x = npc_count, digits = 0)
  
  # Pick a race
  npc_race <- sample(x = dndR::dnd_races(), size = npc_count, replace = TRUE)
  
  # Pick a career
  npc_role <- sample(x = c("acolyte", "adventurer", "ambassador", "anthropologist", "archaeologist", "artisan", "barber", "bounty hunter", "caravan driver", "caravan guard", "carpenter", "charlatan", "city watch", "criminal", "diplomat", "doctor", "farmer", "farrier", "entertainer", "gladiator", "hermit", "initiate", "inquisitor", "investigator", "knight", "mercenary", "merchant", "navigator", "noble", "outlander", "sage", "scholar", "smith", "soldier", "spy", "student of magic", "smuggler", "urchin", "veteran"),
                     size = npc_count, replace = TRUE)
  
  # Assemble into named vector
  npc_info <- data.frame("race" = npc_race, 
                         "job" = npc_role)
  
  # Return the data.frame
  return(npc_info) }



# End ----
