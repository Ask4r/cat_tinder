#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")/.."

# Preserve application-owned Android window policies, including absent files.
backup=$(mktemp -d)
style_variants="values values-night values-v31 values-night-v31"
for variant in $style_variants; do
  source="android/app/src/main/res/$variant/styles.xml"
  if [ -f "$source" ]; then
    cp "$source" "$backup/$variant.xml"
  fi
done
restore_styles() {
  for variant in $style_variants; do
    destination="android/app/src/main/res/$variant/styles.xml"
    if [ -f "$backup/$variant.xml" ]; then
      cp "$backup/$variant.xml" "$destination"
    else
      rm -f "$destination"
    fi
  done
  rm -rf "$backup"
}
trap restore_styles EXIT

dart run icons_launcher:create
dart run flutter_native_splash:create
# Preserve system backgrounds and web metadata/accessibility.
git apply assets/branding/platform-preservation.patch
# System backgrounds replace these generated, now-unreferenced bitmaps.
for variant in drawable drawable-night drawable-v21 drawable-night-v21; do
  rm -f "android/app/src/main/res/$variant/background.png"
done
rm -f ios/Runner/Assets.xcassets/LaunchBackground.imageset/Contents.json \
  ios/Runner/Assets.xcassets/LaunchBackground.imageset/background.png \
  ios/Runner/Assets.xcassets/LaunchBackground.imageset/darkbackground.png
rmdir ios/Runner/Assets.xcassets/LaunchBackground.imageset
