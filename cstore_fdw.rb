require 'formula'

class CstoreFdw < Formula
  homepage 'http://citusdata.github.io/cstore_fdw/'
  head 'https://github.com/citusdata/cstore_fdw.git'

  depends_on 'protobuf-c'
  depends_on 'postgresql'

  def install
    system "make"
    lib.install "cstore_fdw.so"
    # I have no idea how to make this work:
    #ln_s lib/"cstore_fdw.so" Cellar/postgresql/current/lib/cstore_fdw.so"
  end

  def caveats; <<-EOS.undent
    To use cstore_fdw, you must manually edit $PGDATA/postgresql.conf to
    include the following line:
      shared_preload_libraries = 'cstore_fdw'

    You must also link cstore_fdw.so. Example:
      ln -s /usr/local/Cellar/cstore_fdw/HEAD/lib/cstore_fdw.so /usr/local/Cellar/postgresql/9.3.4/lib/

    You may also be able to stop and start postgres as follows:
      brew services restart postgresql
    EOS
  end
end
