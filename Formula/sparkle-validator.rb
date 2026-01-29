class SparkleValidator < Formula
  desc "Validate Sparkle appcast.xml feeds for macOS app updates"
  homepage "https://sparklevalidator.com"
  url "https://registry.npmjs.org/sparkle-validator/-/sparkle-validator-1.1.0.tgz"
  sha256 "c9ae049a2e3678457f811c78053ede28f3f9268a49971c1c3f76be0d4947b5f6"
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
