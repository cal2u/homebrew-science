require 'formula'

class RApp < Formula

  homepage 'http://cran.r-project.org/bin/macosx/'
  url 'http://cran.r-project.org/bin/macosx/Mac-GUI-1.64.tar.gz'
  sha1 '8c31fb05ad990f0c83e94e1921738e0951624bd9'

  head 'https://svn.r-project.org/R-packages/trunk/Mac-GUI'

  depends_on :xcode => :build
  depends_on 'r'

  if !Hardware.is_64_bit?
    onoe "Cannot compile on 32-bit architecture."
  end
  if MacOS.version >= :mountain_lion
    CONFIG = "MLion64"
  elsif MacOS.version >= :lion
    CONFIG = "Lion64"
  elsif MacOS.version >= :snow_leopard
    CONFIG = "SnowLeopard64"
  else
    onoe "Requires Mac OS X Snow Leopard (10.6) or later."
  end

  def install
    if !File.exist?("/Library/Frameworks/R.framework")
      onoe "Framework \"/Library/Frameworks/R.framework\" not found. Create a link:\n\nsudo ln -s \"#{HOMEBREW_PREFIX}/opt/r/R.framework\" \"/Library/Frameworks/R.framework\"\n \n"
    else 
      ohai "Linking to Framework \"/Library/Frameworks/R.framework\"."
    end

    # ugly hack to get updateSVN script in build to not fail
    if build.head?
      cp_r cached_download/".svn", buildpath
    end

    xcodebuild "-target", "R", "-configuration", "#{CONFIG}", "SYMROOT=build"

    prefix.install "build/#{CONFIG}/R.app"
  end
  
end
