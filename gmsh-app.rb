require 'formula'

class GmshApp < Formula
  homepage 'http://geuz.org/gmsh'
  url 'http://geuz.org/gmsh/src/gmsh-2.8.4-source.tgz'
  sha1 'e96209c46874cb278e2028933871c7e7d60e662d'

  depends_on "gmsh" => "with-fltk"
  
  def install
        system "mkdir", "-p", "GMSH.app/Contents/MacOS" 
        system "mkdir", "-p", "GMSH.app/Contents/Resources" 
        system "cp", "Fltk/MacIcons.icns", "GMSH.app/Contents/Resources/Gmsh.icns" 
        system "cp", "Fltk/MacIconsGeo.icns", "GMSH.app/Contents/Resources/GmshGeo.icns" 
        system "cp", "Fltk/MacIconsMsh.icns", "GMSH.app/Contents/Resources/GmshMsh.icns" 
        system "cp", "Fltk/MacIconsSol.icns", "GMSH.app/Contents/Resources/GmshSol.icns" 
        system "cp", "Fltk/MacIconsPos.icns", "GMSH.app/Contents/Resources/GmshPos.icns" 
        system "cp", "utils/misc/gmsh_app.plist",  "GMSH.app/Contents/Info.plist"
        inreplace "GMSH.app/Contents/Info.plist", "GMSH_VERSION", Formula['Octave'].version        
        system "ln", "-s", "#{HOMEBREW_PREFIX}/bin/gmsh", "GMSH.app/Contents/MacOS/gmsh"
        system "ln", "-s", "#{HOMEBREW_PREFIX}/bin/onelab.py", "GMSH.app/Contents/MacOS/onelab.py"
        #install appbundle
        prefix.install "GMSH.app"
    end

end
