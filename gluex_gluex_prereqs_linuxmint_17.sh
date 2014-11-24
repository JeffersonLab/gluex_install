#!/bin/bash
apt-get -y install subversion g++ gfortran xutils-dev libxt-dev libxft-dev \
    liblapack-dev libblas-dev libmotif-dev dpkg-dev libxpm-dev libxext-dev \
    expect libgl1-mesa-dev libmysqlclient-dev tcsh libbz2-dev libfreetype6-dev \
    scons libxml-simple-perl libxml-writer-perl libfile-slurp-perl curl
cd /usr/bin; ln -s make gmake
cd /usr/include; ln -s freetype2 freetype
cd /usr/lib; ln -s liblapack.so.3 liblapack3.so
#!/bin/sh
# brutalize lmms into compiling

# we should be in the /usr/include directory already, but make sure:
cd /usr/include

# produced with 'cd /usr/include/freetype2; ls -d * | tr \\n " "'
FILES="config freetype.h ft2build.h ftadvanc.h ftautoh.h ftbbox.h ftbdf.h ftbitmap.h ftbzip2.h ftcache.h ftcffdrv.h ftchapters.h ftcid.h fterrdef.h fterrors.h ftgasp.h ftglyph.h ftgxval.h ftgzip.h ftimage.h ftincrem.h ftlcdfil.h ftlist.h ftlzw.h ftmac.h ftmm.h ftmodapi.h ftmoderr.h ftotval.h ftoutln.h ftpfr.h ftrender.h ftsizes.h ftsnames.h ftstroke.h ftsynth.h ftsystem.h fttrigon.h ftttdrv.h fttypes.h ftwinfnt.h ftxf86.h t1tables.h ttnameid.h tttables.h tttags.h ttunpat.h"

# give "un" argument to reverse the hack
if [ "$1" == "un" ]; then
  # remove the symlinks
  for V in $FILES; do
      if [ -L "$V" ]; then
          sudo rm "$V"
      fi
  done
else
  for V in $FILES; do
      if [ -L "$V" ]; then
          sudo rm "$V"
      fi
      if [ ! -e "$V" ]; then
          sudo ln -s "freetype2/$V"
      else
          echo "detected potential collision on $V, not linking!"
      fi
  done
fi
