homebrew-morse
==============

Homebrew recipes to install [Morse](https://morse.openrobots.org) and its
dependencies.

# Installation

Morse can be installed using [Homebrew](http://brew.sh):

    brew install python3
    brew tap morse-simulator/morse
    brew install morse-simulator

To upgrade to the latest version:

    brew update
    brew install --upgrade morse-simulator

To uninstall Morse:

    brew uninstall morse-simulator

# Formula Options

The default formula configures and installs Morse for only the sockets
middleware. To following formula options are available to enable middleware
support:

* --with-ros
* --with-moos
* --with-pocolibs
* --with-yarp2

Generating documentation can be enabled with '--with-doc'.
HLA support can be enabled with '--with-hla'.

E.g. to  install Morse with generated documentation and support for ROS:

    brew install morse-simulator --with-doc --with-ros

# ROS Installation Issues

The 1.0 version of Morse has been tested on OSX with ROS Groovy, Python 3.3,
and Blender 2.65. ROS was installed following the Homebrew based installation
instructions given at:

    http://www.ros.org/wiki/groovy/Installation/OSX/Homebrew/Source

In addition to the instructions provided on the ROS website, a version of
rospkg for Python 3 must be installed for Morse to operate properly:

    sudo pip3 install rospkg

