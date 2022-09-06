class LibadmAT0120 < Formula
  desc "Audio Definition Model (ITU-R BS.2076) library"
  homepage "https://libadm.readthedocs.io/en/latest/"

  url "https://github.com/ebu/libadm/archive/0.12.0.tar.gz"
  sha256 "0242b86158ffa1d79b734455faeff7133bfe1bb25303cf6a3893a97dbddb0dc7"

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "boost"

  def install
    ENV.cxx11
    args = std_cmake_args
    args << "-DBUILD_SHARED_LIBS=ON"
    system "cmake", ".", *args
    system "make"
    system "make", "test"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <adm/adm.hpp>

      int main(int argc, char const* argv[]) {
        auto admProgramme = adm::AudioProgramme::create(
          adm::AudioProgrammeName("Alice and Bob talking in the forrest"));

        auto admDocument = adm::Document::create();
        admDocument->add(admProgramme);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "-fvisibility=hidden", "-L#{lib}", "-ladm", "test.cpp", "-o", "test"
    system "./test"
  end
end
