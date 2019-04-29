class AwsSamCli < Formula
  include Language::Python::Virtualenv

  desc "SAM command line interface"
  homepage "https://mysamwebpage.com/aws-sam-cli"
  url "https://github.com/awslabs/aws-sam-cli/archive/v0.6.0.tar.gz"
  sha256 "f85762aba829525eb8c6a52d354ef7254ed37e5bc8a7389885fd0daebfea1c96"
  head "https://github.com/TheSriram/aws-cli.git", :branch => "develop"
  bottle do
    root_url "https://dl.bintray.com/thesriram/aws-sam-cli"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "129f48648395f3bab0bc865c70f4cba33302525d47f1252196f6de1c32b59ec1" => :sierra
  end

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
