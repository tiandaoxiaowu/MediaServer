.PHONY:clean objdir

CXX		= g++
CXXFLAGS	= -Wall -std=c++11 -Wno-deprecated -Wno-sign-compare -Wno-reorder -DENABLE_FAAC -DENABLE_OPENSSL -DENABLE_MP4V2 -DENABLE_X264 -DENABLE_MP4RECORD -D__linux -D__linux__
INCFLAGS	= -Iinclude  
LIBFLAGS	= -Llib -lzlmediakit -lzltoolkit -ljsoncpp -lflv -lmov -lmpeg -lfaac -lssl -lx264 -lmp4v2 -lcrypto -lpthread 
OBJDIR		= obj
OBJS		= $(patsubst %.cpp, $(OBJDIR)/%.o, $(notdir $(wildcard source/*.cpp)))

MEDIASERVER	= mediaserver

all:objdir $(MEDIASERVER)

objdir:$(OBJDIR)
$(OBJDIR):
	mkdir -p $(OBJDIR)

$(MEDIASERVER) : $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LIBFLAGS) 

$(OBJDIR)/%.o : source/%.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(INCFLAGS)

clean:
	rm -f $(OBJDIR)/*.o $(MEDIASERVER)
