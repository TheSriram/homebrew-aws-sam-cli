class AwsSamcli < Formula
  include Language::Python::Virtualenv

  desc "SAM command line interface"
  homepage "https://mysamwebpage.com/aws-sam-cli"
  url "https://www.dropbox.com/s/n8ouzj5mrg4mzpb/aws-sam-cli.tar.gz?dl=0"
  sha256 "55cfcbb5039c731fb6da0c886ae73fcd52f3bc82145ee457250aeed58a6cb695"
  head "https://github.com/TheSriram/aws-cli.git", :branch => "develop"

  bottle do
    cellar :any_skip_relocation
    sha256 "f4a08767ed2c88b68c4a0920e0c26d4a11e0f15da8c2ada114988b4717b047e0" => :mojave
    sha256 "f74796b947d2ed4bdc665054a0de72e2c4641b056fe190081a1a0e5706ebb7a5" => :high_sierra
    sha256 "ee00c838d75b622cc80df1fbd4b9e331d6d6820cf63031e785c61f3531715367" => :sierra
    sha256 "97b011092a64395ebfbd03cf0d749bb198f008bb4c09d38a5d12db9aaa9bdfe4" => :el_capitan
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