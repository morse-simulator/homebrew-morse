homebrew-morse
==============

Homebrew recipes to install Morse (https://morse.openrobots.org) and its dependencies.

# Installation

Morse can be installed using the Homebrew package manager (http://mxcl.github.com/homebrew/) by:

    brew install python3 --universal --framework
    brew tap davidhodo/homebrew-morse
    brew install morse

To completely uninstall Morse:

    brew uninstall morse

To upgrade to the latest version:

    brew update
    brew install --upgrade morse

# Formula Options

The default formula configures and installs Morse for only the sockets middleware.  To following formula options are available to enable middleware support:

* --with-ros
* --with-moos
* --with-pocolibs
* --with-yarp2

Generating documentation can be enabled with '--with-doc'.  HLA support can be enabled with '--with-hla'.

E.g. to  install Morse with generated documentation and support for ROS:

    brew install morse --with-doc --with-ros
