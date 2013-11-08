require 'formula'

class MorseSimulator < Formula
  homepage ''
  url 'https://github.com/laas/morse.git', :tag => '1.1.1'
  #head 'https://github.com/laas/morse.git', :branch => 'master'
  homepage 'http://morse.openrobots.org' 
  version '1.1.1'
  #sha1 '6b484890e2dc7801bcb135193cec3799f42e4208'

  option 'with-ros', 'Enable ROS middleware support'
  option 'with-moos', 'Enable MOOS middleware support'
  option 'with-pocolibs', 'Enable Pocolibs middleware support'
  option 'with-yarp2', 'Enable Yarp2 middleware support'
  option 'with-hla', 'Enable HLA support'
  option 'with-doc', 'Enable documentation generation'


  depends_on 'cmake' => :build
  #depends_on :blender
  depends_on 'python3'

  def install

    # We need to find the Python3 library since the find Python 
    # cmake script does not do a good job of this on OSX
    which_python = `python3 -c 'import sys;print(sys.version[:3])'`.strip
    base_path= `python3 -c 'import os;print(os.__file__[:os.__file__.index("/lib/")])'`.strip
    python_include= base_path + "/Headers"
    python_libs= base_path + "/lib/libpython" + version + ".dylib"

    cmake_args = std_cmake_parameters.split

    cmake_args << "-DPYTHON_MODULE_gaussian_BUILD_SHARED:BOOL=OFF"
    cmake_args << "-DPYTHON_MODULE_zbufferto3d_BUILD_SHARED:BOOL=OFF"
    cmake_args << "-DPYTHON_MODULE_zbuffertodepth_BUILD_SHARED:BOOL=OFF"
    cmake_args << "-DPYTHON_INCLUDE_DIR:PATH=" + python_include
    cmake_args << "-DPYTHON_LIBRARY:FILEPATH=" + python_libs

    # add optional build parameters
    if build.include? 'with-ros'
      cmake_args << "-DBUILD_ROS_SUPPORT:BOOL=ON"
    end

    if build.include? 'with-moos'
      cmake_args << "-DBUILD_MOOS_SUPPORT:BOOL=ON"
    end

    if build.include? 'with-pocolibs'
      cmake_args << "-DBUILD_POCOLIBS_SUPPORT:BOOL=ON"
    end

    if build.include? 'with-yarp2'
      cmake_args << "-DBUILD_YARP2_SUPPORT:BOOL=ON"
    end        

    if build.include? 'with-hla'
      cmake_args << "-DBUILD_HLA_SUPPORT:BOOL=ON"
    end  

    if build.include? 'with-doc'
      cmake_args << "-DBUILD_DOC_SUPPORT:BOOL=ON"
    end  

    system "cmake", ".", *cmake_args
    system "make"
    system "make install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test foo`.
    system "morse check"
  end
end
