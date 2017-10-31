require 'formula'

class RApp < Formula
    
    homepage 'http://cran.r-project.org/bin/macosx/'
    url 'https://cran.r-project.org/bin/macosx/Mac-GUI-1.70.tar.gz'
    sha256 'dc90e0ebb44d7ffa04fb804a145a477518e38b2e45ddbd64a2bcbd8a5067cc4a'
    
    depends_on :xcode => :build
    depends_on 'r'
    
    if !Hardware.is_64_bit?
    onoe "Cannot compile on 32-bit architecture."
end

def install
    if !File.exist?("/Library/Frameworks/R.framework")
        onoe "Framework \"/Library/Frameworks/R.framework\" not found. Create a link:\n\nsudo ln -s \"#{HOMEBREW_PREFIX}/opt/r/R.framework\" \"/Library/Frameworks/R.framework\"\n \n"
    end
    
    xcodebuild "-target", "R", "SYMROOT=build"
    
    prefix.install "build/Release/R.app"
end

end
