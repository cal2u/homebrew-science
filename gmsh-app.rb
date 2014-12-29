require 'formula'

class GmshApp < Formula
  homepage 'http://geuz.org/gmsh'
  url 'http://geuz.org/gmsh/src/gmsh-2.8.5-source.tgz'
  sha1 '352671f95816440ddb2099478f3e9f189e40e27a'

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
