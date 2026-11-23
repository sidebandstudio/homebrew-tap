cask "clawtrate" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1-beta.20261123.8"
  sha256 arm:   "0281cd8eea31559a5b43dd1be817a8be42eb3705ef13efe39cd47cf0b8d04aab",
         intel: "4eed4b3aba3ffeda2eb9ce3d41fec646d9f18197f55f10af221624bdef4e9a97"

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
