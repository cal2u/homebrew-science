require 'formula'

class RApp < Formula
    
    homepage 'http://cran.r-project.org/bin/macosx/'
    url 'http://cran.r-project.org/bin/macosx/Mac-GUI-1.65.tar.gz'
    sha256 '1d8643c91e588da9df6e5b9b6471dc42ba8b080f3aab258e5443af5157bde79b'
    
    head 'https://svn.r-project.org/R-packages/trunk/Mac-GUI'
    
    depends_on :xcode => :build
    depends_on 'r'
    
    if !Hardware.is_64_bit?
    onoe "Cannot compile on 32-bit architecture."
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
    
    xcodebuild "-target", "R", "SYMROOT=build"
    
    prefix.install "build/Release/R.app"
end

end
