executables = xbet_gfort.exe
FC     = gfortran
FFLAGS = -O0 -Wall -Werror=unused-parameter -Werror=unused-variable -Werror=unused-function -Wno-maybe-uninitialized -Wno-surprising -fbounds-check -static -g -fmodule-private
obj    = kind.o bet.o xbet.o

all: $(executables)

# Compile .f90 to .o
%.o: %.f90
	$(FC) $(FFLAGS) -c $<

xbet_gfort.exe: kind.o bet.o xbet.o
	$(FC) -o xbet_gfort.exe kind.o bet.o xbet.o $(FFLAGS)

run: $(executables)
	./xbet_gfort.exe

clean:
	rm -f $(executables) $(obj)

