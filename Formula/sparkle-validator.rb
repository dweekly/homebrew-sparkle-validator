class SparkleValidator < Formula
  desc "Validate Sparkle appcast.xml feeds for macOS app updates"
  homepage "https://sparklevalidator.com"
  url "https://registry.npmjs.org/sparkle-validator/-/sparkle-validator-1.tgz"
  sha256 "c8d3eae160a892e32837db3dcae515e843e5383fef52b8141940c8bcf8b6d59f"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # Test with minimal valid appcast
    (testpath/"appcast.xml").write <<~XML
      <?xml version="1.0" encoding="utf-8"?>
      <rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle">
        <channel>
          <title>Test</title>
          <item>
            <sparkle:version>1.0</sparkle:version>
            <enclosure url="https://example.com/app.zip" length="1234" type="application/octet-stream"/>
          </item>
        </channel>
      </rss>
    XML
    assert_match "VALID", shell_output("#{bin}/sparkle-validator appcast.xml")
  end
end
