WHITE='\033[1;37m'

BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

echo "${BOLD}${WHITE}----------------------------------------------${DEFAULT}"
echo "${BOLD}${WHITE}---------------- Build IPA... ----------------${DEFAULT}"
echo "${BOLD}${WHITE}----------------------------------------------${DEFAULT}"

flutter build ipa --dart-define-from-file=.env

echo "${BOLD}${WHITE}🖥️----------------------------------------------🖥️${DEFAULT}"
echo "${BOLD}${WHITE}🖥️-------- Opening a project in Xcode... -------🖥️${DEFAULT}"
echo "${BOLD}${WHITE}🖥️----------------------------------------------🖥️${DEFAULT}"
open ios/Runner.xcworkspace