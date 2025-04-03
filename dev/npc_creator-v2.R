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

# Isolate names into sub-functions for ease of future maintenance
## Easy to add new names / remove current names
## Easy to maintain `npc_creator` if you don't need to scroll past 100s of lines of names
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

# Expand `npc_creator` to rely on these sub-functions
npc_creator <- function(npc_count = 1){
  
  # NPC count must be a single number
  if(is.null(npc_count) || is.numeric(npc_count) != TRUE || length(npc_count) != 1 || npc_count < 1)
    stop("'npc_count' must be specified as a single, positive number")
  
  # Make sure count is an integer
  npc_count <- round(x = npc_count, digits = 0)
  
  # Make an empty list for storing outputs
  npc_list <- list()
  
  # Iterate across the number of NPCs
  for(k in 1:npc_count){
    
    # Pick a race
    npc_race <- sample(x = dndR::dnd_races(), size = 1)
    
    # Pick a job
    npc_job <- sample(x = c("acolyte", "adventurer", "ambassador", "anthropologist", "archaeologist", "artisan", "barber", "bounty hunter", "caravan driver", "caravan guard", "carpenter", "charlatan", "city watch", "criminal", "diplomat", "doctor", "farmer", "farrier", "entertainer", "gladiator", "hermit", "initiate", "inquisitor", "investigator", "knight", "mercenary", "merchant", "navigator", "noble", "outlander", "sage", "scholar", "smith", "soldier", "spy", "student of magic", "smuggler", "urchin", "veteran"),
                      size = 1)
    
    # Toss a coin
    flip <- dndR::coin()
    
    # Pick a first name from one of the ref functions
    if(flip == 1){
      npc_first <- sample(x = first_names_fem(), size = 1)
    } else {
      npc_first <- sample(x = first_names_masc(), size = 1)
    }
    
    # Pick a last name
    npc_last <- sample(x = surnames(), size = 1)
    
    # Assemble this information into a dataframe
    npc_list[[paste("npc_", k)]] <- data.frame("name" = paste(npc_first, npc_last),
                                               "race" = npc_race, 
                                               "job" = npc_job)
    
    
    } # Close the loop
  
  # Collapse list into a dataframe
  npc_df <- purrr::list_rbind(x = npc_list)
  
  # Return the data.frame
  return(npc_df) }

# Test the function
npc_creator(npc_count = 3)


# End ----
