class AwsSamCli < Formula
  include Language::Python::Virtualenv

  desc "SAM command line interface"
  homepage "https://mysamwebpage.com/aws-sam-cli"
  url "https://www.dropbox.com/s/m23f6t258f7ekbz/aws-sam-cli-0.6.0.tar.gz"
  sha256 "22c9f6ddcdec5a16a6131c11614c6a51e6f7fd376e496fd1efe8eb15a058f8c2"
  head "https://github.com/TheSriram/aws-cli.git", :branch => "develop"

  # Some AWS APIs require TLS1.2, which system Python doesn't have before High
  # Sierra
  depends_on "python"

  def install
    venv = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "aws-sam-cli"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "Usage", shell_output("#{bin}/sam --help")
  end
end
