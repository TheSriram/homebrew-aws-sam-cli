class AwsSamCli < Formula
  include Language::Python::Virtualenv

  desc "SAM command line interface"
  homepage "https://docs.aws.amazon.com/serverless-application-model/latest/developerguide"
  url "https://files.pythonhosted.org/packages/6c/e7/bfd43ec02c19865b852a8a4351b5af193adecae8116a967903b8854277f9/aws-sam-cli-0.6.1.tar.gz"
  sha256 "446dc06b9f081f4975e5bf1933a7017486278df160ae9dffa35f35eb84114357"
  head "https://github.com/TheSriram/aws-sam-cli.git", :branch => "develop"
  bottle do
    root_url "https://dl.bintray.com/thesriram/aws-sam-cli"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "e861e50c9a0b5b595dd4c0a548796d05cc449aa64dc14e6a989e00ba92aa7700" => :sierra
    sha256 "8792b7889e53099e8dc63dab61e88bc0d039a277413b64bd3ab103ac8fbb8a1e" => :x86_64_linux
  end

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
