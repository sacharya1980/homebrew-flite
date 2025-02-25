class Flite < Formula
  desc "Small, fast speech synthesis engine (text-to-speech)"
  homepage "https://github.com/festvox/flite"
  url "https://github.com/festvox/flite/archive/refs/tags/v2.2.tar.gz"
  sha256 "ab1555fe5adc3f99f1d4a1a0eb1596d329fd6d74f1464a0097c81f53c0cf9e5c"
  license "BSD-3-Clause"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  patch :DATA

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

__END__
diff --git a/main/Makefile b/main/Makefile
index 1da18a8..8166182 100644
--- a/main/Makefile
+++ b/main/Makefile
@@ -34,6 +34,13 @@
 ##  Top level user programs                                              ##
 ##                                                                       ##
 ###########################################################################
+# MacOS does not accept -pd options to the cp command
+    UNAME_S := $(shell uname -s)
+ifeq ($(UNAME_S),Darwin)
+CP_FLAGS='-r'
+else
+CP_FLAGS='-pd'
+endif
 TOP=..
 DIRNAME=main
 BUILD_DIRS = 
@@ -152,8 +159,8 @@ install:
 	done
 	$(INSTALL) -m 755 $(BINDIR)/flite_time $(DESTDIR)$(INSTALLBINDIR)
 #       The libraries: static and shared (if built)
-	cp -pd $(flite_LIBS_deps) $(DESTDIR)$(INSTALLLIBDIR)
+	cp $(CP_FLAGS) $(flite_LIBS_deps) $(DESTDIR)$(INSTALLLIBDIR)
 ifdef SHFLAGS
-	cp -pd $(SHAREDLIBS) $(VERSIONSHAREDLIBS) $(DESTDIR)$(INSTALLLIBDIR)
+	cp $(CP_FLAGS) $(SHAREDLIBS) $(VERSIONSHAREDLIBS) $(DESTDIR)$(INSTALLLIBDIR)
 endif
