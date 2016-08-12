class HandlebarsC < Formula
  desc "C implementation of handlebars.js"
  homepage "https://github.com/jbboehr/handlebars.c"
  url "https://github.com/jbboehr/handlebars.c/archive/v0.5.2.tar.gz"
  sha256 "bcca2a55351f38a9a9dfb133a73c30eb08ddc33263dca4a2d4726dd902bfbc38"

  bottle do
    cellar :any
    sha256 "0dd997d2f9d3b90c22508cade8d8b09ac2cf5786f652cbf83bfcadc74927a87d" => :el_capitan
    sha256 "b7a242eaa0b859ad10b556b6f346ffe996d74ee143d8c8c1bece096d0259dc2d" => :yosemite
    sha256 "213b965b007820824417bb3ac927e068a10a0b0c1c6a2f720ec0269e9e9f0589" => :mavericks
  end

  depends_on "check" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"
  depends_on "json-c"
  depends_on "libyaml"
  depends_on "lmdb"
  depends_on "talloc"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-debug",
                          "--without-handlebars-spec",
                          "--without-mustache-spec",
                          "--disable-refcounting",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS
    #include <handlebars.h>
    int main() {
        handlebars_version();
        return 0;
    }
    EOS
    system ENV.cc, "-c", "-o", (testpath/"test.o"), (testpath/"test.c")
    system ENV.cc, "-o", (testpath/"test"), (testpath/"test.o"), "-L#{lib}", "-lhandlebars"
    system (testpath/"test")
  end
end
