require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Handlebars < AbstractPhp70Extension
  init
  desc "PHP bindings for handlebars.c"
  homepage "https://github.com/jbboehr/php-handlebars"
  url "https://github.com/jbboehr/php-handlebars/archive/v0.7.3.tar.gz"
  sha256 "1bd14d1df8dadfa83c438a9f5ddaf6e6833ba343814f45e080f9c3776f0db114"

  depends_on "handlebars.c"

  def install
    ENV.universal_binary if build.universal?
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/handlebars.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("handlebars")
  end
end
