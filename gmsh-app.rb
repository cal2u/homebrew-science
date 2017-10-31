require 'formula'

class GmshApp < Formula
  desc "GUI for GMSH"
  homepage "http://geuz.org/gmsh"
  url "https://gmsh.info/src/gmsh-3.0.5-source.tgz"
  sha256 "ae39ed81178d94b76990b8c89b69a5ded8910fd8f7426b800044d00373d12a93"

  depends_on "gmsh" => "with-fltk"

  def install
        mkdir_p "GMSH.app/Contents/MacOS"
        mkdir_p "GMSH.app/Contents/Resources"
        cp "Fltk/MacIcons.icns", "GMSH.app/Contents/Resources/Gmsh.icns"
        cp "Fltk/MacIconsGeo.icns", "GMSH.app/Contents/Resources/GmshGeo.icns"
        cp "Fltk/MacIconsMsh.icns", "GMSH.app/Contents/Resources/GmshMsh.icns"
        cp "Fltk/MacIconsSol.icns", "GMSH.app/Contents/Resources/GmshSol.icns"
        cp "Fltk/MacIconsPos.icns", "GMSH.app/Contents/Resources/GmshPos.icns"
        cp "utils/misc/gmsh_app.plist",  "GMSH.app/Contents/Info.plist"
        inreplace "GMSH.app/Contents/Info.plist", "GMSH_VERSION", Formula['gmsh'].version
        ln_s "#{HOMEBREW_PREFIX}/bin/gmsh", "GMSH.app/Contents/MacOS/gmsh"
        ln_s "#{Formula["gmsh"].opt_libexec}/onelab.py", "GMSH.app/Contents/MacOS/onelab.py"
        #install appbundle
        prefix.install "GMSH.app"
    end

end
