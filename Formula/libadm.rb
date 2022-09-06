class Libadm < Formula
  desc "Audio Definition Model (ITU-R BS.2076) library"
  homepage "https://libadm.readthedocs.io/en/latest/"

  url "https://github.com/ebu/libadm/archive/0.13.0.tar.gz"
  sha256 "34c317a8d38ca3f82386b39a7377b2ebf23fb692d7f2f5949648aec342c3f0ff"

  head "https://github.com/ebu/libadm.git"

  depends_on "cmake" => :build
  depends_on "boost"

  def install
    ENV.cxx11
    args = std_cmake_args
    args << "-DADM_UNIT_TESTS=OFF"
    system "cmake", ".", "-B", "shared", *args, "-DBUILD_SHARED_LIBS=ON"
    system "cmake", "--build", "shared"
    system "cmake", "--build", "shared", "--target", "install"
    system "cmake", ".", "-B", "static", *args, "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "static"
    system "cmake", "--build", "static", "--target", "install"
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
    system ENV.cxx, "-std=c++14", "-fvisibility=hidden", "-L#{lib}", "-ladm", "test.cpp", "-o", "test"
    system "./test"
  end
end
