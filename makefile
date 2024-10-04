HOME = ./

DEFINES = -Dvfloat=double -DGCC27X

#INCLUDE = -I/home/xxx/programs/alglib/cpp/src

#ALGLIB = /home/xxx/programs/alglib/cpp/src/

# option -std=c++0x to enable regex

#OPT = -O0 -std=c++0x
OPT = -std=c++0x

#MAC USERS
# INCLUDE = -I/opt/homebrew/include
# LIBS = -L/opt/homebrew/lib -lboost_regex-mt

#LINUX USERS
INCLUDE = -I/usr/include/boost
LIBS = -L/usr/lib/boost -lboost_regex


wfmextract: wfmextract.o
	g++ -o wfmextract wfmextract.o $(INCLUDE) $(DEFINES) $(LIBS) -lm -lpthread

ag: ag.o
	g++ -o ag ag.o interpolation.o solvers.o integration.o specialfunctions.o optimization.o ap.o alglibinternal.o alglibmisc.o linalg.o $(INCLUDE) $(DEFINES) $(LIBS) -lm -lboost -lpthread 	
	
wfmextract.o: wfmextract.cc
	g++ -g -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) wfmextract.cc

ag.o: ag.cc
	g++ -g -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) ag.cc

interpolation.o: $(ALGLIB)interpolation.cpp
	g++ -g -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)interpolation.cpp

ap.o: $(ALGLIB)ap.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)ap.cpp

alglibinternal.o: $(ALGLIB)alglibinternal.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)alglibinternal.cpp

alglibmisc.o: $(ALGLIB)alglibmisc.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)alglibmisc.cpp

linalg.o: $(ALGLIB)linalg.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)linalg.cpp

solvers.o: $(ALGLIB)solvers.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)solvers.cpp

optimization.o: $(ALGLIB)optimization.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)optimization.cpp

integration.o: $(ALGLIB)integration.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)integration.cpp

specialfuncitons.o: $(ALGLIB)specialfunctions.cpp
	g++  -c $(OPT) $(INCLUDE) $(DEFINES) $(LIBS) $(ALGLIB)specialfunctions.cpp

       
