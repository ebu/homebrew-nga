class LibadmAT0100 < Formula
  desc "Audio Definition Model (ITU-R BS.2076) library"
  homepage "https://libadm.readthedocs.io/en/latest/"

  url "https://github.com/ebu/libadm/archive/0.10.0.tar.gz"
  sha256 "99d48e829d7e5283758add1e27c67681a4691eea2b0891b95e7702743d1b249a"

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
    system ENV.cxx, "-std=c++11", "-fvisibility=hidden", "-L#{lib}", "-llibadm", "test.cpp", "-o", "test"
    system "./test"
  end
end
