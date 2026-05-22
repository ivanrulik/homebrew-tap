cask "piano-book-pro" do
  version "0.1.1"
  sha256 "695446f4d96fc7e868419cada2db507dba671a5068b3c742e096c5e354ff8451"

  url "https://github.com/ivanrulik/homebrew-tap/releases/download/piano-book-pro-v#{version}/PianoBookPro-#{version}.zip"
  name "Piano Book Pro"
  desc "Menu-bar app that turns your typing into piano"
  homepage "https://github.com/ivanrulik/homebrew-tap"

  livecheck do
    url "https://github.com/ivanrulik/homebrew-tap/releases.atom"
    regex(/piano-book-pro[-_]v?(\d+(?:\.\d+)+)/i)
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
