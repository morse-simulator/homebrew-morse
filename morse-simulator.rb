require 'formula'

class MorseSimulator < Formula
  homepage 'http://morse.openrobots.org'
  url 'https://github.com/morse-simulator/morse.git', :tag => '1.3'
  head 'https://github.com/morse-simulator/morse.git'

  option 'with-ros', 'Enable ROS middleware support'
  option 'with-moos', 'Enable MOOS middleware support'
  option 'with-pocolibs', 'Enable Pocolibs middleware support'
  option 'with-yarp2', 'Enable Yarp2 middleware support'
  option 'with-hla', 'Enable HLA support'
  option 'with-pymorse' 'Enable the PyMorse binding'
  option 'with-doc', 'Enable documentation generation'
  option 'with-python=', 'Select the right python interpreter'

  depends_on 'cmake' => :build

  def which_python3
    python3 = ARGV.value("with-python") || which("python3").to_s
    fail "#{python3} not found" unless File.exist? python3
    python3
  end

  def install
    cmake_args = std_cmake_parameters.split

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

    if build.include? 'with-pymorse'
      cmake_args << "-DPYMORSE_SUPPORT:BOOL=ON"
    end

    if build.include? 'with-python='
    	cmake_args << "-DPYTHON_EXECUTABLE=#{which_python3}"
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
