class Libbw64 < Formula
  desc "Broadcast Wave 64 (ITU-R BS.2088) library"
  homepage "https://libbw64.readthedocs.io/en/latest/"

  url "https://github.com/ebu/libbw64/archive/0.10.0.tar.gz"
  sha256 "4ae6e02868f98cfeadb50c4f246527a4d2d6013ee483790a04bb997591416d21"

  head "https://github.com/ebu/libbw64.git"

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    args = std_cmake_args
    args << "-DUNIT_TESTS=OFF"
    system "cmake", ".", *args
    system "cmake", "--build", "."
    system "cmake", "--build", ".", "--target", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <bw64/bw64.hpp>
      #include <vector>

      int main(int argc, char const* argv[]) {
        auto bw64File = bw64::writeFile("test.wav");

        std::vector<float> buffer(512, 0.f);
        bw64File->write(&buffer.front(), buffer.size());

        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test"
    system "./test"
  end
end
