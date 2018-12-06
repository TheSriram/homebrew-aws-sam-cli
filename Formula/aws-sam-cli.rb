class AwsSamCli < Formula
  include Language::Python::Virtualenv

  desc "SAM command line interface"
  homepage "https://docs.aws.amazon.com/serverless-application-model/latest/developerguide"
  url "https://files.pythonhosted.org/packages/8f/29/a0cb402d1875d0b35aa7c99b644a75fc72762dce25bc4fce7d62e1b70825/aws-sam-cli-0.8.1.tar.gz"
  sha256 "cdcc9864f4b37865bf5669df9a91a4a0d0ed4ab4975ba4ad9e4e4b84012c3345"
  head "https://github.com/TheSriram/aws-sam-cli.git", :branch => "develop"
  bottle do
  end

  depends_on "python3"

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
