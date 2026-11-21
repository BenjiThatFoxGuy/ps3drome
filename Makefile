#---------------------------------------------------------------------------------
# PS3drome - Subsonic/Navidrome client for PS3
#---------------------------------------------------------------------------------

# Target
TARGET		:= ps3drome
BUILD		:= build
SOURCES		:= source
DATA		:= data
INCLUDES	:= include

# Compiler/linker
CC			:= $(PS3DEV)/ppu/bin/ppu-gcc
CXX			:= $(PS3DEV)/ppu/bin/ppu-g++
OBJCOPY		:= $(PS3DEV)/ppu/bin/ppu-objcopy
STRIP		:= $(PS3DEV)/ppu/bin/ppu-strip
SPRX		:= $(PS3DEV)/bin/sprxlinker
FSELF		:= $(PS3DEV)/bin/fself.py
SFO			:= $(PS3DEV)/bin/sfo.py
PKG			:= $(PS3DEV)/bin/pkg.py
MAKE_SELF	:= $(PS3DEV)/bin/make_self_npdrm
CONTENT_ID	:= UP0001-PS3DROME_00-0000000000000000

# Flags
CFLAGS		:= -O2 -Wall -mcpu=cell $(foreach dir,$(INCLUDES),-I$(dir))
CXXFLAGS	:= $(CFLAGS)
LDFLAGS		:= -L$(PSL1GHT)/ppu/lib
LIBS		:= -lnet -lsysutil -lrt -llv2 -lm -lnetctl -lhttp -lhttputil -lssl

#---------------------------------------------------------------------------------
# Source files
#---------------------------------------------------------------------------------
CFILES		:= $(foreach dir,$(SOURCES),$(wildcard $(dir)/*.c))
CPPFILES	:= $(foreach dir,$(SOURCES),$(wildcard $(dir)/*.cpp))
OFILES		:= $(CFILES:.c=.o) $(CPPFILES:.cpp=.o)

#---------------------------------------------------------------------------------
# Targets
#---------------------------------------------------------------------------------
.PHONY: all clean pkg

all: $(TARGET).self

$(TARGET).elf: $(OFILES)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)
	$(SPRX) $@

$(TARGET).self: $(TARGET).elf
	$(FSELF) $< $@

pkg: $(TARGET).self
	$(SFO) --title "PS3drome" --appid "PS3DROME" -f $(BUILD)/PARAM.SFO
	mkdir -p $(BUILD)/pkg/USRDIR
	cp $(TARGET).self $(BUILD)/pkg/USRDIR/EBOOT.BIN
	cp $(BUILD)/PARAM.SFO $(BUILD)/pkg/PARAM.SFO
	$(PKG) --contentid $(CONTENT_ID) $(BUILD)/pkg/ $(TARGET).pkg

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OFILES) $(TARGET).elf $(TARGET).self $(TARGET).pkg
	rm -rf $(BUILD)
