cask "clawtrate" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1-beta.20261125.12"
  sha256 arm:   "7ed89fe67e11f161da642ce4b231ae1d7699200556ef46ed0fbe87d34805bc5f",
         intel: "841b55f2843e36f25e6be57dfb09c3c98253f0dba2aeda383abe9b79f41ac7f4"

  url "https://github.com/sidebandstudio/clawtrate/releases/download/v#{version}/Clawtrate-#{version}-mac-#{arch}.zip"
  name "Clawtrate"
  desc "Desktop client for OpenClaw"
  homepage "https://clawtrate.dev/"

  # Clawtrate ships as GitHub prereleases for now, so they count here; drafts do not.
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-beta\.\d+(?:\.\d+)*)?)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  auto_updates true
  depends_on macos: :ventura

  app "Clawtrate.app"

  zap trash: [
    "~/Library/Application Support/Clawtrate",
    "~/Library/Preferences/dev.clawtrate.desktop.plist",
  ]
end
