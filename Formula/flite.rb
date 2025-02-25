class Flite < Formula
  desc "Small, fast speech synthesis engine (text-to-speech)"
  homepage "https://github.com/festvox/flite"
  url "https://github.com/festvox/flite/archive/refs/tags/v2.2.tar.gz"
  sha256 "ab1555fe5adc3f99f1d4a1a0eb1596d329fd6d74f1464a0097c81f53c0cf9e5c"
  license "BSD-3-Clause"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/flite", "-t", "Hello Homebrew!"
  end
end
