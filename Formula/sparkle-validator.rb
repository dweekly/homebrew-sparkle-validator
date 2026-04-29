class SparkleValidator < Formula
  desc "Validate Sparkle appcast.xml feeds for macOS app updates"
  homepage "https://sparklevalidator.com"
  url "https://registry.npmjs.org/sparkle-validator/-/sparkle-validator-1.2.1.tgz"
  sha256 "fd1634dc178fbb8ecff65ba0d5b62011afbb64d29e98e3456da5f809b75598aa"
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
