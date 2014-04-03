require "formula"

class OctaveApp < Formula
  homepage "http://www.gnu.org/software/octave/index.html"
  url      "http://wiki.octave.org/wiki/images/9/96/Icon.png"
  sha1     "98b6b556d882e41939abf79fb117a37309dae52a"
  version  "1"
  
  #depends_on "octave"

  keg_only "This is only an empty app bundle calling Octave."

  def install
    system('mkdir',"-p","#{buildpath}/Octave.app/Contents/MacOS/")
    exe = File.open('Octave.app/Contents/MacOS/Octave', 'w')
    exe.write("#!/bin/bash\n")
    exe.write("export PATH=#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/sbin:${PATH}\n")
    exe.write("exec #{HOMEBREW_PREFIX}/bin/octave -i --force-gui | logger 2>&1\n")
    exe.close()
    system('chmod','a=rx','Octave.app/Contents/MacOS/Octave')
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleDevelopmentRegion","English")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleDisplayName","Octave")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleExecutable","Octave")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleIconFile","appIcon.icns")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleIdentifier","org.octave.Octave")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleInfoDictionaryVersion","6.0")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleName","Octave")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundlePackageType","APPL")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleShortVersionString", Formula['Octave'].version)
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","CFBundleVersion", Formula['Octave'].version)
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","LSMinimumSystemVersion","10.9.1")
    system('defaults','write',"#{buildpath}/Octave.app/Contents/Info","NSHumanReadableCopyright","© 2014 JWE and others")
    system('plutil','-convert','xml1',"#{buildpath}/Octave.app/Contents/Info.plist")
    system('mkdir',"-p","#{buildpath}/appIcon.iconset")
    system('mkdir',"-p","#{buildpath}/Octave.app/Contents/Resources/")
    system("sips -z 16 16 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_16x16.png")
    system("sips -z 32 32 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_16x16@2x.png")
    system("sips -z 32 32 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_32x32.png")
    system("sips -z 64 64 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_32x32@2x.png")
    system("sips -z 128 128 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_128x128.png")
    system("sips -z 256 256 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_128x128@2x.png")
    system("sips -z 256 256 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_256x256.png")
    system("sips -z 1024 1024 #{buildpath}/Icon.png --out #{buildpath}/appIcon.iconset/icon_512x512@2x.png")
    system('cp','Icon.png',"#{buildpath}/appIcon.iconset/icon_256x256@2x.png")
    system('mv','Icon.png',"#{buildpath}/appIcon.iconset/icon_512x512.png")
    system("iconutil -c icns -o #{buildpath}/Octave.app/Contents/Resources/appIcon.icns #{buildpath}/appIcon.iconset")
    prefix.install "Octave.app"
  end

  def caveats
     <<-EOS.undent
         .app bundles were installed.
         Run `brew linkapps` to symlink these to /Applications.
       EOS
  end
end
