Sebastian's Homebrew-Science Repository
============
This repository contains some scientific apps with their appbundles. It is necessary due to the unfortunate discontinuation of [homebrew-science](https://github.com/Homebrew/homebrew-science/issues/6365).

Installing Formulae
--------------------------------
Just `brew tap schoeps/homebrew-science` and then `brew install <formula>`. You may want to execute `brew tap-pin schoeps/homebrew-science` to make sure that you always use the latest software from this repository.

The following formulae are available 
- GetDP (e.g. `brew install getdp`)
- Gmsh (e.g. `brew install gmsh --with-fltk`)
- Octave (e.g. `brew install octave --HEAD --with-gui --with-java`)

The following app-bundles are available 
- Gmsh-App (e.g. `brew install gmsh-app`)
- R-App (e.g. `brew install r-app`)
- Octave-App (e.g. `brew install octave-app`)

Hopefully coming soon
- ngsolve
- netgen

You can also install via URL:

```
brew install https://raw.github.com/schoeps/homebrew-science/master/<formula>.rb
```

Docs
----
`brew help`, `man brew`, or the Homebrew [homepage](https://brew.sh).