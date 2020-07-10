#-*-makefile-*-   ; force emacs to enter makefile-mode
# ----------------------------------------------------
# %CopyrightBegin%
#
# Copyright Ericsson AB 2009-2013. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# %CopyrightEnd%

# The version.
#
# Note that it is important that the version is
# explicitly expressed here. Some applications need to
# be able to check this value *before* configure has
# been run and generated otp_ded.mk
DED_MK_VSN = 2
# ----------------------------------------------------
# Variables needed for building Dynamic Erlang Drivers
# ----------------------------------------------------
DED_CC = gcc
DED_GCC = yes
DED_LD = gcc
DED_LDFLAGS = -m64 -bundle -bundle_loader /Users/johnmelody_mynapse/Downloads/otp_src_22.3/bin/x86_64-apple-darwin19.4.0/beam.smp
DED_BASIC_CFLAGS = -Werror=undef -Werror=implicit -Werror=return-type  -Wdeclaration-after-statement -Wall -Wstrict-prototypes -Wmissing-prototypes  -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS -fno-common -g -O2   -fPIC -fno-common
DED_THR_DEFS =  -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS
DED_WERRORFLAGS = -Werror=undef -Werror=implicit -Werror=return-type 
DED_WARN_FLAGS = -Wdeclaration-after-statement -Wall -Wstrict-prototypes -Wmissing-prototypes
DED_CFLAGS = -Werror=undef -Werror=implicit -Werror=return-type  -Wdeclaration-after-statement -Wall -Wstrict-prototypes -Wmissing-prototypes  -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS -fno-common -g -O2   -fPIC -fno-common
DED_LD_FLAG_RUNTIME_LIBRARY_PATH = 
DED_STATIC_CFLAGS = -Werror=undef -Werror=implicit -Werror=return-type    -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS -fno-common -g -O2   -fno-common -DSTATIC_ERLANG_NIF -DSTATIC_ERLANG_DRIVER
DED_LIBS = 
DED_EXT = so
DED_OSTYPE = unix
PRIVDIR = ../priv
OBJDIR = $(PRIVDIR)/obj/$(TARGET)
LIBDIR = $(PRIVDIR)/lib/$(TARGET)
DED_SYS_INCLUDE = -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/emulator/beam -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include/x86_64-apple-darwin19.4.0 -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include/internal -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include/internal/x86_64-apple-darwin19.4.0 -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/emulator/sys/unix -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/emulator/sys/common
DED_INCLUDES = -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/emulator/beam -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include/x86_64-apple-darwin19.4.0 -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include/internal -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/include/internal/x86_64-apple-darwin19.4.0 -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/emulator/sys/unix -I/Users/johnmelody_mynapse/Downloads/otp_src_22.3/erts/emulator/sys/common
