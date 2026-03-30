cask "openhantek" do
  arch arm: "arm64", intel: "x86_64"

  version "3.4.0"
  sha256 arm:   "30eeffc9267bc8b9a8ac60fbfe8b4cf2454bd43ec593d229ff6f5d67eb85e734",
         intel: "4a4d223e1f767ddb84a54c48885541903fa01b55f0b271b5b2cd4f3aab7fa4a8"

  url "https://github.com/OpenHantek/OpenHantek6022/releases/download/#{version}/openhantek_#{version}_osx_#{arch}.dmg",
      verified: "github.com/OpenHantek/OpenHantek6022/"
  name "OpenHantek6022"
  desc "Free software for Hantek USB digital signal oscilloscopes"
  homepage "https://github.com/OpenHantek/OpenHantek6022"

  livecheck do
    url :homepage
    regex(/releases\/tag\/v?(\d+(?:\.\d+)*)/i)
    strategy :github_latest
  end

  app "OpenHantek.app"

  postflight do
    # Ad-hoc code signing is required for unsigned app to run on modern macOS
    system "codesign", "--force", "--deep", "--sign", "-", staged_path/"OpenHantek.app"
  end

  zap trash: [
    "~/Library/Preferences/com.openhantek*",
    "~/Library/Preferences/org.openhantek.OpenHantek6022.plist",
    "~/Library/Saved Application State/OpenHantek.savedState"
  ]
end
