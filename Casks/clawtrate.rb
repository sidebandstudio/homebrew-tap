cask "clawtrate" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1-beta.20261127.6"
  sha256 arm:   "d5d99b0b5362ecea6655c91afd145b46cd9b9663c48ba6b9aa9fef25f123f392",
         intel: "1c57fe0288f0768009ccfbba72bbaea3fe9f71f104bad9e8a9a0ab2141813caf"

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
