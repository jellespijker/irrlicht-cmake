from conans import ConanFile, CMake, tools

class IrrlichtConan(ConanFile):
    name = "irrlicht"
    version = "1.8.4"
    license = "http://irrlicht.sourceforge.net/?page_id=294"
    url = "https://github.com/jellespijker/irrlicht-cmake"
    description = "An open source high performance realtime 3D engine written in C++"
    exports = "LICENSE.md"
    exports_sources = ["*", "!cmake-build-*"]
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": True, "fPIC": True}
    requires = ["libx11/1.6.8@bincrafters/stable",
                "opengl/virtual@bincrafters/stable",
                "zlib/1.2.11",
                "libpng/1.6.37@bincrafters/stable",
                "libjpeg/9c@bincrafters/stable",
                "libzip/1.5.2@bincrafters/stable",
                "lzma/5.2.4@bincrafters/stable"]
    generators = "cmake_find_package", "cmake_paths"

    _cmake = None

    def config_options(self):
        if self.settings.os == "Windows" or self.options.shared:
            del self.options.fPIC

    def configure(self):
        self.options["libx11"].shared = True

    def _configure_cmake(self):
        if self._cmake is None:
            self._cmake = CMake(self)
        self._cmake.definitions["IRRLICHT_STATIC_LIBRARY"] = "ON" if self.options.shared else "OFF"
        self._cmake.definitions["IRRLICHT_BUILD_EXAMPLES"] = "OFF"
        self._cmake.definitions["IRRLICHT_BUILD_TOOLS"] = "OFF"
        self._cmake.definitions["IRRLICHT_INSTALL_MEDIA_FILES"] = "OFF"
        self._cmake.definitions["USE_NON_SYSTEM_JPEG"] = "OFF"
        self._cmake.definitions["USE_NON_SYSTEM_PNG"] = "OFF"
        self._cmake.definitions["USE_NON_SYSTEM_BZIP2"] = "OFF"
        self._cmake.definitions["USE_NON_SYSTEM_LZMA"] = "OFF"
        self._cmake.definitions["USE_NON_SYSTEM_ZLIP"] = "OFF"
        self._cmake.verbose = True
        self._cmake.configure()
        return self._cmake

    def build(self):
        cmake = self._configure_cmake()
        cmake.build()

    def package(self):
        self.copy(pattern="LICENSE", dst="licenses")
        cmake = self._configure_cmake()
        cmake.install()

    def package_info(self):
        self.cpp_info.libs = tools.collect_libs(self)