cask "clawtrate" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1-beta.20261127.8"
  sha256 arm:   "084c26d91387794aa1fe1bdb5a8e3787deb48de598c1a46d63a4780a42a3685b",
         intel: "c32eba0e99368d4f295fd47bdd1079c8f63bdb3161f738d9d1c7f30c63b15a42"

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
