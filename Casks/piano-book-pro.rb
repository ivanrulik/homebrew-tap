cask "piano-book-pro" do
  version "0.1.0"
  sha256 "5146532dab2a7ee2a4a21dd0aa4b69183eef925f6e909d87e87c414e2a202279"

  url "https://github.com/ivanrulik/piano_book_pro/releases/download/v#{version}/PianoBookPro-#{version}.zip",
      verified: "github.com/ivanrulik/piano_book_pro/"
  name "Piano Book Pro"
  desc "Menu-bar app that turns your typing into piano"
  homepage "https://github.com/ivanrulik/piano_book_pro"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "PianoBookPro.app"

  postflight do
    # Ad-hoc signed; strip the quarantine xattr so the first launch doesn't
    # need a right-click → Open. Remove this once the app is notarized.
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/PianoBookPro.app"],
                   sudo: false
  end

  uninstall quit: "build.lightspeed.PianoBookPro"

  zap trash: [
    "~/Library/Application Support/PianoBookPro",
    "~/Library/Preferences/build.lightspeed.PianoBookPro.plist",
    "~/Music/PianoBookPro",
  ]

  caveats <<~EOS
    Piano Book Pro captures keystrokes system-wide via Accessibility.
    On first launch:
      1. Click the piano-keys icon in your menu bar
      2. Click "Grant…"
      3. In System Settings, toggle PianoBookPro on
  EOS
end
