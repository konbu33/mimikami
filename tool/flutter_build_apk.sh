function currentDateTime() {
    date '+%Y/%m/%d %H:%M'
}

# -------------------------------------------------- 
# 
# flutter clean; flutter pub get
# 
# -------------------------------------------------- 
currentDateTime
flutter clean; flutter pub get

# -------------------------------------------------- 
# 
# create app icon
# 
# -------------------------------------------------- 
currentDateTime
flutter pub run flutter_launcher_icons -f flutter_launcher_icons.yaml

# -------------------------------------------------- 
# 
# flutter buiid apk
# 
# -------------------------------------------------- 
currentDateTime
flutter build apk --split-per-abi
