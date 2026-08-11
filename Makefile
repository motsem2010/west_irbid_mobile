
#copy this file to any project in lib/ then
#install vs code or android studio extension which name (Makefile) then you can use each command in below as shortcut for
#multi commands

#  run : make cg

cg:
	flutter clean
	flutter pub get

update_major:
	flutter pub upgrade --major-versions

refresh_ios:
	@if [ -f ios/Podfile.lock ]; then rm ios/Podfile.lock; fi
	pod deintegrate ios/Runner.xcodeproj
	pod install --project-directory=ios

 publish_ios:
	xcrun altool --upload-app --type ios -f build/ios/ipa/*.ipa --apiKey LXJ99DCB56 --apiIssuer 1786219f-1dbb-4e20-9ddd-904869307845


COUNTRY := jo

get_versions:
	@echo "== iOS App Info =="; \
	if [ -f "./ios/Runner/GoogleService-Info.plist" ]; then \
		PLIST_PATH="./ios/Runner/GoogleService-Info.plist"; \
	elif [ -f "./ios/GoogleService-Info.plist" ]; then \
		PLIST_PATH="./ios/GoogleService-Info.plist"; \
	else \
		echo "❌ GoogleService-Info.plist not found for iOS"; \
		exit 1; \
	fi; \
	bundle_id=$$(/usr/bin/plutil -extract BUNDLE_ID raw -o - "$$PLIST_PATH"); \
	if [ -z "$$bundle_id" ]; then \
		echo "❌ Failed to read iOS bundle ID"; \
		exit 1; \
	fi; \
	echo "🔎 iOS bundle ID: $$bundle_id"; \
	response_file=$$(mktemp); \
	curl -s "https://itunes.apple.com/lookup?bundleId=$$bundle_id&country=$(COUNTRY)" > "$$response_file"; \
	if ! jq empty "$$response_file" 2>/dev/null; then \
		echo "❌ iTunes API response invalid JSON:"; \
		cat "$$response_file"; \
		rm "$$response_file"; \
		exit 1; \
	fi; \
	jq -r '.results | if length > 0 then "📱 Version: " + .[0].version + "\n🆔 Bundle ID: " + .[0].bundleId + "\n📛 Track Name: " + .[0].trackName else "❌ No app found on iTunes" end' "$$response_file"; \
	rm "$$response_file"; \
	\
	echo "\n== Android App Info =="; \
	if [ ! -f "android/app/src/main/AndroidManifest.xml" ]; then \
		echo "❌ AndroidManifest.xml not found"; \
		exit 1; \
	fi; \
	package_name=$$(sed -n 's/.*package="\([^"]*\)".*/\1/p' android/app/src/main/AndroidManifest.xml | head -1); \
	if [ -z "$$package_name" ]; then \
		echo "❌ Failed to read Android package name"; \
		exit 1; \
	fi; \
	echo "🔎 Android package name: $$package_name"; \
	echo "🔎 Google Play Store URL Click on About this app: https://play.google.com/store/apps/details?id=$$package_name";

add-lang:
	@key=$$(echo "$(KEY)" | awk '{for(i=1;i<=NF;i++) if(i==1) printf "%s%s", tolower(substr($$i,1,1)), substr($$i,2); else printf "%s%s", toupper(substr($$i,1,1)), substr($$i,2); print ""}'); \
	file="lib/src/views/res/language.dart"; \
	echo "Adding $$key..."; \
	awk -v k="$$key" -v ar="$(AR)" -v en="$(EN)" ' \
	  /abstract class Language with ChangeNotifier/ { print; print "  String get " k ";"; next } \
	  /class ArLanguage extends Language/ { print; print "  @override\n  String get " k " => \047" ar "\047;"; next } \
	  /class EnLanguage extends Language/ { print; print "  @override\n  String get " k " => \047" en "\047;"; next } \
	  { print } \
	' "$$file" > "$$file.tmp" && mv "$$file.tmp" "$$file"; \
	echo "✅ Done"
add-lang-p:
	@key=$$(echo "$(KEY)" | awk '{for(i=1;i<=NF;i++) if(i==1) printf "%s%s", tolower(substr($$i,1,1)), substr($$i,2); else printf "%s%s", toupper(substr($$i,1,1)), substr($$i,2); print ""}'); \
	file="lib/views/res/language.dart"; \
	echo "Adding $$key..."; \
	awk -v k="$$key" -v ar="$(AR)" -v en="$(EN)" ' \
	  /abstract class Language with ChangeNotifier/ { print; print "  String get " k ";"; next } \
	  /class ArLanguage extends Language/ { print; print "  @override\n  String get " k " => \047" ar "\047;"; next } \
	  /class EnLanguage extends Language/ { print; print "  @override\n  String get " k " => \047" en "\047;"; next } \
	  { print } \
	' "$$file" > "$$file.tmp" && mv "$$file.tmp" "$$file"; \
	echo "✅ Done"


#  run : make aab
 aab:
	make ato
	flutter build appbundle --release

#  run : make apk
 apk:
	make ata
	flutter build apk --release
#  run : make apk
 apk64:
	make ata
	flutter build apk --analyze-size --target-platform=android-arm64 --split-per-abi

#  run : make ipa
 ipa:
	make ato
	flutter build ipa

 openx:
	open ios/Runner.xcworkspace

#  run : make ato # means api_test_off
#this command to remove apiTest = true; line in main
 ato:
	@sed -i.bak 's/apiTest *= *true;/apiTest = false;/' lib/main.dart && rm lib/main.dart.bak


 ata:
	@sed -i.bak 's/apiTest *= *false;/apiTest = true;/' lib/main.dart && rm lib/main.dart.bak


#  run : make build_apps
 build_apps:
	make cg
	make aab
	make ipa


.PHONY: update_version
# update android version in pubspec.yaml and local.properties
#  run : make update_version
 update_version:
	@awk '{if ($$1 == "version:") {split($$2, version, /[.+]/); major=version[1]; minor=version[2]; patch=version[3]+1; build=version[4]+1; $$2=major "." minor "." patch "+" build} print}' pubspec.yaml > pubspec.tmp && mv pubspec.tmp pubspec.yaml

	@awk -F= 'BEGIN {OFS="="} \
	/^flutter.versionName/ {split($$2, ver, /\./); ver[3]++; $$2=ver[1]"."ver[2]"."ver[3]} \
	/^flutter.versionCode/ {$$2=$$2+1} \
	1' android/local.properties > android/local.tmp && mv android/local.tmp android/local.properties




# Variables
IPA_DIR := build/ios/ipa
BUNDLE_ID := $(shell \
    if [ -f "$(PWD)/ios/Runner/GoogleService-Info.plist" ]; then \
        /usr/libexec/PlistBuddy -c "Print :BUNDLE_ID" "$(PWD)/ios/Runner/GoogleService-Info.plist" 2>/dev/null || echo ""; \
    elif [ -f "$(PWD)/ios/GoogleService-Info.plist" ]; then \
        /usr/libexec/PlistBuddy -c "Print :BUNDLE_ID" "$(PWD)/ios/GoogleService-Info.plist" 2>/dev/null || echo ""; \
    else \
        echo ""; \
    fi \
)

# Log file
LOG_FILE := upload.log

# Build the IPA file
ipa_test:
	@echo "Starting Flutter IPA build..." | tee -a $(LOG_FILE)
	flutter build ipa --export-method ad-hoc 2>&1 | tee -a $(LOG_FILE)
	@echo "IPA build completed!" | tee -a $(LOG_FILE)

# Upload the IPA file after building
ipa_test_link:
	@echo "Looking for IPA file..." | tee -a $(LOG_FILE)
	IPA_FILE=$(shell ls $(IPA_DIR)/*.ipa 2>/dev/null | head -n 1); \
	if [ -z "$$IPA_FILE" ]; then \
		echo "Error: No IPA file found!" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	if [ -z "$(BUNDLE_ID)" ]; then \
		echo "Error: Bundle ID not found!" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	echo "Found IPA file: $$IPA_FILE" | tee -a $(LOG_FILE); \
	echo "Bundle ID: $(BUNDLE_ID)" | tee -a $(LOG_FILE); \
	echo "Starting upload..." | tee -a $(LOG_FILE); \
	curl -X POST https://hamza-apps.com/Apps/upload.php \
		-F "ipa=@$$IPA_FILE" \
		-F "bundleID=$(BUNDLE_ID)" 2>&1 | tee -a $(LOG_FILE); \

.PHONY:

mts:
	sed -i '' 's|path: /Users/pioneers/bitbucket-school/e-school-new-ui|path: /Users/pioneers/bitbucket-pioneer-school/e-shcool|g' pubspec.yaml

hmz:
	sed -i '' 's|path: /Users/pioneers/bitbucket-pioneer-school/e-shcool|path: /Users/pioneers/bitbucket-school/e-school-new-ui|g' pubspec.yaml

api35:
	sed -i '' 's/        targetSdk = flutter.targetSdkVersion/        targetSdk = 35/' android/app/build.gradle
	@echo "Available commands:"

.PHONY: upload-apk help clean-logs

# Firebase Storage configuration
FIREBASE_BUCKET ?= api-profiling.firebasestorage.app
APK_NAME ?= app-arm64-v8a-release.apk
APK_PATH ?= build/app/outputs/flutter-apk/$(APK_NAME)
LOG_FILE := upload-apk.log
SERVICE_ACCOUNT_PATH := /Users/pioneers/profiling.json
FIREBASE_DB_URL := https://api-profiling-default-rtdb.firebaseio.com/apks
MAIN_DART := lib/main.dart
PUBSPEC_YAML := pubspec.yaml

help:
	@echo "Available commands:"
	@echo "  make upload-apk              - Upload APK to Firebase Storage and update database"
	@echo "  make clean-logs              - Remove log files"

clean-logs:
	@rm -f $(LOG_FILE)
	@echo "✅ Logs cleaned"

upload-apk:
	@echo "🚀 Starting APK upload..." | tee $(LOG_FILE)
	@echo "APK: $(APK_PATH)" | tee -a $(LOG_FILE)
	@echo "" | tee -a $(LOG_FILE)
	@if [ ! -f "$(APK_PATH)" ]; then \
		echo "❌ Error: APK file not found at $(APK_PATH)" | tee -a $(LOG_FILE); \
		exit 1; \
	fi
	@echo "📊 APK Size: $$(du -h $(APK_PATH) | cut -f1)" | tee -a $(LOG_FILE)
	@echo "" | tee -a $(LOG_FILE)
	@echo "📖 Reading app configuration..." | tee -a $(LOG_FILE)
	@SCHOOL_NAME=$$(grep 'Main.currentSchool = School\.' $(MAIN_DART) | sed -n 's/.*School\.\([a-zA-Z0-9_]*\).*/\1/p' | head -1); \
	if [ -z "$$SCHOOL_NAME" ]; then \
		echo "❌ Error: Could not find school name in $(MAIN_DART)" | tee -a $(LOG_FILE); \
		echo "Looking for line: Main.currentSchool = School.XXX;" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	echo "School: $$SCHOOL_NAME" | tee -a $(LOG_FILE); \
	VERSION=$$(grep '^version:' $(PUBSPEC_YAML) | sed 's/version: *\([0-9.]*\).*/\1/'); \
	BUILD_NUMBER=$$(grep '^version:' $(PUBSPEC_YAML) | sed 's/.*+\([0-9]*\).*/\1/'); \
	if [ -z "$$VERSION" ] || [ -z "$$BUILD_NUMBER" ]; then \
		echo "❌ Error: Could not read version from $(PUBSPEC_YAML)" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	echo "Version: $$VERSION ($$BUILD_NUMBER)" | tee -a $(LOG_FILE); \
	CURRENT_DATETIME=$$(date '+%Y-%m-%d_%H-%M-%S'); \
	STORAGE_FILENAME="$$SCHOOL_NAME-v$$VERSION-b$$BUILD_NUMBER-$$CURRENT_DATETIME.apk"; \
	STORAGE_PATH="$$SCHOOL_NAME/$$STORAGE_FILENAME"; \
	echo "Storage Path: $$STORAGE_PATH" | tee -a $(LOG_FILE); \
	echo "" | tee -a $(LOG_FILE); \
	echo "🔑 Activating service account..." | tee -a $(LOG_FILE); \
	if [ ! -f "$(SERVICE_ACCOUNT_PATH)" ]; then \
		echo "❌ Error: Service account key file not found" | tee -a $(LOG_FILE); \
		echo "Expected location: $(SERVICE_ACCOUNT_PATH)" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	gcloud auth activate-service-account --key-file=$(SERVICE_ACCOUNT_PATH) 2>&1 | tee -a $(LOG_FILE); \
	if [ $$? -ne 0 ]; then \
		echo "❌ Error: Failed to activate service account" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	echo "✅ Service account activated" | tee -a $(LOG_FILE); \
	echo "Account: $$(gcloud config get-value account)" | tee -a $(LOG_FILE); \
	echo "" | tee -a $(LOG_FILE); \
	echo "🔑 Getting access token..." | tee -a $(LOG_FILE); \
	ACCESS_TOKEN=$$(gcloud auth print-access-token 2>&1); \
	if [ $$? -ne 0 ]; then \
		echo "❌ Error: Failed to get access token from gcloud" | tee -a $(LOG_FILE); \
		echo "Response: $$ACCESS_TOKEN" | tee -a $(LOG_FILE); \
		echo "" | tee -a $(LOG_FILE); \
		echo "Make sure you have:" | tee -a $(LOG_FILE); \
		echo "  1. gcloud CLI installed: https://cloud.google.com/sdk/docs/install" | tee -a $(LOG_FILE); \
		echo "  2. Service account key file at: $(SERVICE_ACCOUNT_PATH)" | tee -a $(LOG_FILE); \
		echo "  3. Service account has necessary Firebase permissions" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	if [ -z "$$ACCESS_TOKEN" ]; then \
		echo "❌ Error: Empty access token from gcloud" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	TOKEN_LEN=$$(echo -n "$$ACCESS_TOKEN" | wc -c); \
	echo "✅ Access token obtained ($$TOKEN_LEN bytes)" | tee -a $(LOG_FILE); \
	echo "Token preview: $$(echo "$$ACCESS_TOKEN" | cut -c1-20)..." | tee -a $(LOG_FILE); \
	echo "" | tee -a $(LOG_FILE); \
	echo "📡 Initiating resumable upload..." | tee -a $(LOG_FILE); \
	INIT_RESPONSE=$$(curl -s -i -X POST \
		"https://firebasestorage.googleapis.com/v0/b/$(FIREBASE_BUCKET)/o?name=$$STORAGE_PATH&uploadType=resumable" \
		-H "Authorization: Bearer $$ACCESS_TOKEN" \
		-H "Content-Type: application/vnd.android.package-archive" \
		-H "X-Goog-Upload-Protocol: resumable" \
		-H "X-Goog-Upload-Command: start" 2>&1); \
	echo "$$INIT_RESPONSE" >> $(LOG_FILE); \
	SESSION_URL=$$(echo "$$INIT_RESPONSE" | grep -i '^x-goog-upload-url' | cut -d' ' -f2- | tr -d '\r'); \
	if [ -z "$$SESSION_URL" ]; then \
		echo "❌ Error: Failed to get session URL" | tee -a $(LOG_FILE); \
		echo "Init Response:" | tee -a $(LOG_FILE); \
		echo "$$INIT_RESPONSE" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	echo "✅ Session URL obtained" | tee -a $(LOG_FILE); \
	echo "" | tee -a $(LOG_FILE); \
	echo "⬆️  Uploading APK file (this may take a while)..." | tee -a $(LOG_FILE); \
	UPLOAD_RESPONSE=$$(curl -s -w "\n%{http_code}" -X PUT "$$SESSION_URL" \
		-H "Content-Type: application/vnd.android.package-archive" \
		-H "X-Goog-Upload-Protocol: resumable" \
		-H "X-Goog-Upload-Command: upload, finalize" \
		-H "X-Goog-Upload-Offset: 0" \
		--data-binary @$(APK_PATH) 2>&1); \
	HTTP_CODE=$$(echo "$$UPLOAD_RESPONSE" | tail -n1); \
	UPLOAD_BODY=$$(echo "$$UPLOAD_RESPONSE" | sed '$$d'); \
	echo "HTTP Status Code: $$HTTP_CODE" >> $(LOG_FILE); \
	echo "Upload Response:" >> $(LOG_FILE); \
	echo "$$UPLOAD_BODY" | head -c 500 >> $(LOG_FILE); \
	echo "" >> $(LOG_FILE); \
	if [ "$$HTTP_CODE" != "200" ]; then \
		echo "" | tee -a $(LOG_FILE); \
		echo "❌ Error: Upload failed with HTTP code $$HTTP_CODE" | tee -a $(LOG_FILE); \
		echo "Response (first 500 chars): $$(echo "$$UPLOAD_BODY" | head -c 500)" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	echo "" | tee -a $(LOG_FILE); \
	DOWNLOAD_TOKEN=$$(echo "$$UPLOAD_BODY" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data.get('downloadTokens', ''))" 2>/dev/null); \
	if [ -z "$$DOWNLOAD_TOKEN" ]; then \
		DOWNLOAD_TOKEN=$$(echo "$$UPLOAD_BODY" | grep -o '"downloadTokens":"[^"]*"' | cut -d'"' -f4); \
	fi; \
	if [ -z "$$DOWNLOAD_TOKEN" ]; then \
		echo "❌ Error: Failed to extract download token" | tee -a $(LOG_FILE); \
		echo "Upload response: $$UPLOAD_BODY" | tee -a $(LOG_FILE); \
		exit 1; \
	fi; \
	ENCODED_PATH=$$(echo "$$STORAGE_PATH" | sed 's/\//%2F/g'); \
	DOWNLOAD_URL="https://firebasestorage.googleapis.com/v0/b/$(FIREBASE_BUCKET)/o/$$ENCODED_PATH?alt=media&token=$$DOWNLOAD_TOKEN"; \
	echo "✅ Upload successful!" | tee -a $(LOG_FILE); \
	echo "" | tee -a $(LOG_FILE); \
	echo "📦 APK Download URL:" | tee -a $(LOG_FILE); \
	echo "$$DOWNLOAD_URL" | tee -a $(LOG_FILE); \
	echo "" | tee -a $(LOG_FILE); \
	echo "📝 Updating Firebase Realtime Database..." | tee -a $(LOG_FILE); \
	CREATION_DATE=$$(date '+%Y-%m-%d %H:%M'); \
	JSON_DATA="{\"schoolName\":\"$$SCHOOL_NAME-v$$VERSION ($$BUILD_NUMBER)\",\"fileDownloadUrl\":\"$$DOWNLOAD_URL\",\"creationDateTime\":\"$$CREATION_DATE\"}"; \
	DB_RESPONSE=$$(curl -s -w "\n%{http_code}" -X POST "$(FIREBASE_DB_URL)/$$SCHOOL_NAME.json" \
		-H 'Content-Type: application/json' \
		-d "$$JSON_DATA" 2>&1); \
	DB_HTTP_CODE=$$(echo "$$DB_RESPONSE" | tail -n1); \
	DB_BODY=$$(echo "$$DB_RESPONSE" | sed '$$d'); \
	echo "Database HTTP Code: $$DB_HTTP_CODE" >> $(LOG_FILE); \
	echo "Database Response: $$DB_BODY" >> $(LOG_FILE); \
	if [ "$$DB_HTTP_CODE" != "200" ]; then \
		echo "⚠️  Warning: Database update returned HTTP $$DB_HTTP_CODE" | tee -a $(LOG_FILE); \
		echo "But APK was uploaded successfully" | tee -a $(LOG_FILE); \
	else \
		echo "✅ Database updated!" | tee -a $(LOG_FILE); \
	fi; \
	echo "" | tee -a $(LOG_FILE); \
	echo "🎉 Process completed successfully!" | tee -a $(LOG_FILE); \
	echo "   School: $$SCHOOL_NAME" | tee -a $(LOG_FILE); \
	echo "   Version: v$$VERSION ($$BUILD_NUMBER)" | tee -a $(LOG_FILE); \
	echo "   Storage Path: $$STORAGE_PATH" | tee -a $(LOG_FILE); \
	echo "   Download URL: $$DOWNLOAD_URL" | tee -a $(LOG_FILE); \
	echo "" | tee -a $(LOG_FILE); \
	echo "📝 Full logs saved to: $(LOG_FILE)"


check_updates:
	dart run /Users/pioneers/bitbucket-school/e-school-new-ui/lib/src/check_updates_run.dart