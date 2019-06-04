class AwsSamCli < Formula
  include Language::Python::Virtualenv

  desc "SAM command line interface"
  homepage "https://mysamwebpage.com/aws-sam-cli"
  url "https://github.com/awslabs/aws-sam-cli/archive/v0.16.1.tar.gz"
  sha256 "b863265bb768147fd2bac6d424581af2ace8855d8d855e324a49f39a8c4c066a"
  head "https://github.com/TheSriram/aws-sam-cli.git", :branch => "develop"
  bottle do
    root_url "https://github.com/TheSriram/homebrew-aws-sam-cli/releases/download/v0.16.1/"
    sha256 "646a73abc522f3365ebfef06215b7d88b35c8b6c2ad70dbcd267f98fd994e4d9" => :el_capitan
    sha256 "01c8c4ab9317db6bb2b74ce64918872c616aa0c73db9111dd19292fb096e78f4" => :x86_64_linux
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
