#!/usr/bin/env bash
# Compile l'APK sans Android Studio ni SDK Google.
# Prérequis (Ubuntu/Debian) : sudo apt install aapt apksigner zipalign dalvik-exchange openjdk-17-jdk
# Le framework Android (android.jar) vient de Maven Central (Robolectric android-all).
# Clé de signature : $FDT_KEYSTORE (+ $FDT_KS_PASS) ; sinon une clé locale est générée dans build/ (non versionnée).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
APP="$ROOT/app/src/main"
OUT="$ROOT/build/manual"
CACHE="$ROOT/build/cache"
VERSION_CODE="${VERSION_CODE:-$(git -C "$ROOT" rev-list --count HEAD 2>/dev/null || echo 1)}"
VERSION_NAME="1.0.$VERSION_CODE"
ANDROID_ALL="14-robolectric-10818077"
BT="$(ls -d /usr/lib/android-sdk/build-tools/*/ | tail -1)"
DEST="${1:-$ROOT/../FrontsDuTemps.apk}"

rm -rf "$OUT"; mkdir -p "$OUT/classes" "$OUT/gen" "$CACHE"
ANDROID_JAR="${ANDROID_JAR:-$CACHE/android-all-$ANDROID_ALL.jar}"
if [ ! -f "$ANDROID_JAR" ]; then
  echo "→ Téléchargement du framework Android ($ANDROID_ALL)"
  curl -fsSL -o "$ANDROID_JAR.part" "https://repo1.maven.org/maven2/org/robolectric/android-all/$ANDROID_ALL/android-all-$ANDROID_ALL.jar"
  mv "$ANDROID_JAR.part" "$ANDROID_JAR"
fi

echo "→ Ressources + jeu (www/)"
sed 's|<manifest |<manifest package="com.frontsdutemps.game" |' "$APP/AndroidManifest.xml" > "$OUT/AndroidManifest.xml"
"$BT/aapt2" compile --dir "$APP/res" -o "$OUT/res.zip"
"$BT/aapt2" link -o "$OUT/base.apk" -I "$ANDROID_JAR" --manifest "$OUT/AndroidManifest.xml" \
  --min-sdk-version 26 --target-sdk-version 34 --version-code "$VERSION_CODE" --version-name "$VERSION_NAME" \
  -A "$ROOT/../www" --java "$OUT/gen" "$OUT/res.zip"

echo "→ Java"
find "$APP/java" "$OUT/gen" -name '*.java' > "$OUT/sources.txt"
javac -nowarn -Xlint:-options --release 8 -encoding UTF-8 -classpath "$ANDROID_JAR" -d "$OUT/classes" @"$OUT/sources.txt"

echo "→ Dex"
"$BT/dx" --dex --min-sdk-version=26 --output="$OUT/classes.dex" "$OUT/classes"

echo "→ Assemblage et signature"
cp "$OUT/base.apk" "$OUT/unsigned.apk"
(cd "$OUT" && zip -q unsigned.apk classes.dex)
zipalign -f -p 4 "$OUT/unsigned.apk" "$OUT/aligned.apk"
KS="${FDT_KEYSTORE:-$ROOT/build/fdt-local.keystore}"
if [ ! -f "$KS" ]; then
  PASS="$(openssl rand -hex 16)"; echo "$PASS" > "$KS.pass"
  keytool -genkeypair -keystore "$KS" -alias fdt -keyalg RSA -keysize 2048 -validity 20000 \
    -storepass "$PASS" -keypass "$PASS" -dname "CN=Fronts du Temps" >/dev/null 2>&1
fi
PASS="${FDT_KS_PASS:-$(cat "$KS.pass")}"
apksigner sign --ks "$KS" --ks-key-alias fdt --ks-pass "pass:$PASS" --key-pass "pass:$PASS" --out "$DEST" "$OUT/aligned.apk"
apksigner verify "$DEST" && echo "✓ APK : $DEST ($(du -h "$DEST" | cut -f1))"
