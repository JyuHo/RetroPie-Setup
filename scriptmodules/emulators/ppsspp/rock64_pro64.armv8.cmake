include_directories(SYSTEM
  /usr/include
  /usr/include/GLES2
  /usr/include/EGL
)

set(ARCH_FLAGS "-O2 -marm -march=armv8-a+crc -mtune=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations -pipe")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ARCH_FLAGS}"  CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)

set(CMAKE_EXE_LINKER_FLAGS "-L/usr/lib/arm-linux-gnueabihf/" CACHE STRING "" FORCE)

set(OPENGL_LIBRARIES /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2)
set(EGL_LIBRARIES /usr/lib/arm-linux-gnueabihf/libEGL.so)

set(OPENGL_LIBRARIES GLESv2)
set(ARMV7 ON)
set(USING_GLES2 ON)
set(FORCED_CPU armv7)
