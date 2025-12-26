#!/bin/bash

APP_NAME="$1"
BIN_NAME="$2"

if [[ -z "$APP_NAME" || -z "$BIN_NAME" ]]; then
  echo "Usage: $0 APP_NAME BIN_NAME"
  exit 1
fi

mkdir -p "$APP_NAME/Contents"

cat > "$APP_NAME/Contents/Info.plist" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>TestActiveApp</string>
    <key>CFBundleIdentifier</key>
    <string>com.yourname.TestActiveApp</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleExecutable</key>
    <string>$BIN_NAME</string>
    <key>LSUIElement</key>
    <true/>
</dict>
</plist>
EOL
echo "Info.plist generated for $APP_NAME with executable $BIN_NAME"
