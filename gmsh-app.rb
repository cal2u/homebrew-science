require 'formula'

class GmshApp < Formula
  desc "GUI for GMSH"
  homepage "http://geuz.org/gmsh"
  url "http://gmsh.info/src/gmsh-2.14.0-source.tgz"
  sha256 "8b344f29ace99167578158fcc4854461630b26808cff9e2dea134ab4267991cd"

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
