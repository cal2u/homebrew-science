require "formula"

class OctaveApp < Formula
  url "https://ftp.gnu.org/gnu/octave/octave-4.2.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/octave/octave-4.2.1.tar.gz"
  sha256 "80c28f6398576b50faca0e602defb9598d6f7308b0903724442c2a35a605333b"
  version  "2"
  
  depends_on "octave"

  keg_only "This is only an empty app bundle calling Octave."

  def install
    #create applescript to start octave
    exe = File.open("Octave.applescript", 'w')
    exe.write('--
    on open argv
      set filename to "\'" & POSIX path of item 1 of argv & "\'"
      do shell script "PATH=/usr/local/bin/:$PATH;cd ~;/usr/local/bin/octave --force-gui --persist --eval \"edit " & filename & "\" | logger 2>&1"
    end open
    on run
    do shell script "PATH=/usr/local/bin/:$PATH;cd ~;/usr/local/bin/octave --force-gui  | logger 2>&1"
    end run')
    exe.close()
    #create appbundle
    system('osacompile',"-oOctave.app","Octave.applescript")
    #modify some entries in the plist 
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","NSUIElement","1")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleIdentifier","org.octave.Octave")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleShortVersionString", Formula['Octave'].version)
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleVersion", Formula['Octave'].version)
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","NSHumanReadableCopyright","© 2014 JWE and others")
    system("defaults write #{buildpath}/Octave.app/Contents/Info CFBundleDocumentTypes -array \'{ \"CFBundleTypeExtensions\" = (\"m\"); \"CFBundleTypeOSTypes\" = (\"Mfile\"); \"CFBundleTypeRole\" = \"Editor\";}\'")    
    system('plutil','-convert','xml1',"#{buildpath}/Octave.app/Contents/Info.plist")
    system('chmod','a=r',"#{buildpath}/Octave.app/Contents/Info.plist")
    #create a nice icon
    system('mkdir',"-p","droplet.iconset")
    system("sips -z 16 16 Icon.png --out droplet.iconset/icon_16x16.png")
    system("sips -z 32 32 Icon.png --out droplet.iconset/icon_16x16@2x.png")
    system("sips -z 32 32 Icon.png --out droplet.iconset/icon_32x32.png")
    system("sips -z 64 64 Icon.png --out droplet.iconset/icon_32x32@2x.png")
    system("sips -z 128 128 Icon.png --out droplet.iconset/icon_128x128.png")
    system("sips -z 256 256 Icon.png --out droplet.iconset/icon_128x128@2x.png")
    system("sips -z 256 256 Icon.png --out droplet.iconset/icon_256x256.png")
    system("sips -z 1024 1024 Icon.png --out droplet.iconset/icon_512x512@2x.png")
    system('cp','Icon.png',"droplet.iconset/icon_256x256@2x.png")
    system('mv','Icon.png',"droplet.iconset/icon_512x512.png")
    system("iconutil -c icns -o #{buildpath}/Octave.app/Contents/Resources/droplet.icns #{buildpath}/droplet.iconset")
    #install appbundle
    prefix.install "Octave.app"
  end

  def caveats
     <<-EOS.undent
         .app bundles were installed.
         Run `brew linkapps` to symlink these to /Applications.
       EOS
  end
end
