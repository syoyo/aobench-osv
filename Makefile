# Copyright (C) 2014 Cloudius Systems, Ltd.
#
# This work is open source software, licensed under the terms of the
# BSD license as described in the LICENSE file in the top-level directory.

CXX=g++-4.8
CXXFLAGS  = -g -fopenmp -O2 -Wall -std=c++11 -fPIC $(INCLUDES)

# statically link gomp(GNU openmp)
#LDFLGAS = `${CXX} -print-file-name=libgomp.a`

TARGET = ao

OBJ_FILES = ao.o

quiet = $(if $V, $1, @echo " $2"; $1)
very-quiet = $(if $V, $1, @$1)

all: $(TARGET).so

%.o: %.cc
	$(call quiet, $(CXX) $(CXXFLAGS) -c -o $@ $<, CXX $@)

$(TARGET).so: $(OBJ_FILES)
	$(call quiet, $(CXX) $(CXXFLAGS) -shared -o $(TARGET).so $^ $(LDFLGAS), LINK $@)

clean:
	$(call quiet, rm -f $(TARGET).so $(OBJ_FILES), CLEAN)
