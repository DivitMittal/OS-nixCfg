{
  lib,
  stdenv,
  swiftPackages,
  fetchFromGitHub,
  apple-sdk,
}:
stdenv.mkDerivation rec {
  pname = "SakuraWallpaper";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "yueseqaz";
    repo = "SakuraWallpaper";
    rev = "7d4ed563da42e8eac8627ffc7991a24ae6691902";
    hash = "sha256-9c6VnNNKByrsAjO38TYMlZOlHkk/ZxkzKLXrHBtpu58=";
  };

  nativeBuildInputs = [swiftPackages.swift];
  buildInputs = [apple-sdk];

  buildPhase = ''
    runHook preBuild

    swiftc -o SakuraWallpaper \
      SettingsManager.swift \
      MediaType.swift \
      Localization.swift \
      ScreenPlayer.swift \
      WallpaperManager.swift \
      MainWindowController.swift \
      ThumbnailItem.swift \
      AboutWindowController.swift \
      AppDelegate.swift \
      main.swift \
      -sdk ${apple-sdk.sdkroot} \
      -framework Cocoa \
      -framework AVKit \
      -framework AVFoundation \
      -framework ServiceManagement

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    APP_DIR="$out/Applications/SakuraWallpaper.app"
    mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources"

    install -m755 SakuraWallpaper "$APP_DIR/Contents/MacOS/SakuraWallpaper"

    # Localization resources
    cp -r Resources/. "$APP_DIR/Contents/Resources/"

    # App icon
    cp AppIcon.icns "$APP_DIR/Contents/Resources/"

    # Required bundle signature marker
    printf 'APPL????' > "$APP_DIR/Contents/PkgInfo"

    cat > "$APP_DIR/Contents/Info.plist" <<EOF
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>CFBundleExecutable</key>
      <string>SakuraWallpaper</string>
      <key>CFBundleIconFile</key>
      <string>AppIcon</string>
      <key>CFBundleIdentifier</key>
      <string>com.sakura.wallpaper</string>
      <key>CFBundleName</key>
      <string>SakuraWallpaper</string>
      <key>CFBundlePackageType</key>
      <string>APPL</string>
      <key>CFBundleVersion</key>
      <string>${version}</string>
      <key>CFBundleShortVersionString</key>
      <string>${version}</string>
      <key>LSMinimumSystemVersion</key>
      <string>12.0</string>
      <key>LSUIElement</key>
      <true/>
      <key>NSHighResolutionCapable</key>
      <true/>
    </dict>
    </plist>
    EOF

    runHook postInstall
  '';

  meta = {
    description = "Dynamic wallpaper app — set videos and images as live macOS wallpapers";
    homepage = "https://github.com/yueseqaz/SakuraWallpaper";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
  };
}
