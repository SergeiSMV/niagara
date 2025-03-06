WHITE='\033[1;37m'

BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

echo "${BOLD}${WHITE}----------------------------------------------${DEFAULT}"
echo "${BOLD}${WHITE}------------ Build Release APK... ------------${DEFAULT}"
echo "${BOLD}${WHITE}----------------------------------------------${DEFAULT}"

flutter build apk --dart-define-from-file=.env --release -t lib/main.dart

echo "${BOLD}${WHITE}----------------------------------------------${DEFAULT}"
echo "${BOLD}${WHITE}-------- Opening a project in folder... -------${DEFAULT}"
echo "${BOLD}${WHITE}----------------------------------------------${DEFAULT}"
open build/app/outputs/flutter-apk/