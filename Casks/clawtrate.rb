cask "clawtrate" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1-beta.20261123.5"
  sha256 arm:   "3db44bb31822b7ef431a9f5991689b57223491e9069ad0462ad31eed1e8b65c3",
         intel: "760d3caf425e132e9703e482759a6d967b11b4333185a7d2cae2793d4d83db1b"

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
