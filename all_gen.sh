BLUE='\033[1;34m'
DEFAULT='\033[0m'
GREEN='\033[1;32m'
DARK_GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'

BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

echo
echo "${BLUE}🧹----------------------------------------------🧹${DEFAULT}"
echo "${BLUE}🧹--------------- :: Clean... :: ---------------🧹${DEFAULT}"
echo "${BLUE}🧹----------------------------------------------🧹${DEFAULT}"

flutter clean 

echo
echo "${BLUE}📚----------------------------------------------📚${DEFAULT}"
echo "${BLUE}📚--------------- :: Pub get... :: -------------📚${DEFAULT}"
echo "${BLUE}📚----------------------------------------------📚${DEFAULT}"

flutter pub get 

echo
echo "${PURPLE}📲----------------------------------------------📲${DEFAULT}"
echo "${PURPLE}📲------------ :: Pod install... :: ------------📲${DEFAULT}"
echo "${PURPLE}📲----------------------------------------------📲${DEFAULT}"
 
cd ios 
pod install --repo-update 
cd -

echo "${BOLD}${GREEN}✅-------------------------------------------✅${DEFAULT}"
echo "${BOLD}${GREEN}✅--------------- :: Done! :: ---------------✅${DEFAULT}"
echo "${BOLD}${GREEN}✅-------------------------------------------✅${DEFAULT}"
echo


echo
echo "${YELLOW}🖼️----------------------------------------------🖼️${DEFAULT}"
echo "${YELLOW}🖼️-------- :: Resource generation... :: --------🖼️${DEFAULT}"
echo "${YELLOW}🖼️----------------------------------------------🖼️${DEFAULT}"

fluttergen

echo
echo "${CYAN}🌎----------------------------------------------🌎${DEFAULT}"
echo "${CYAN}🌎------ :: Localization generation... :: ------🌎${DEFAULT}"
echo "${CYAN}🌎----------------------------------------------🌎${DEFAULT}"

dart run slang

echo
echo "${BLUE}🚀----------------------------------------------🚀${DEFAULT}"
echo "${BLUE}🚀---------- :: Run build runner... :: ---------🚀${DEFAULT}"
echo "${BLUE}🚀----------------------------------------------🚀${DEFAULT}"

flutter pub run build_runner build --delete-conflicting-outputs

echo "${BOLD}${GREEN}✅-------------------------------------------✅${DEFAULT}"
echo "${BOLD}${GREEN}✅--------------- :: Done! :: ---------------✅${DEFAULT}"
echo "${BOLD}${GREEN}✅-------------------------------------------✅${DEFAULT}"
echo