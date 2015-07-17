all: mapa

mapa:
	javac -d build/classes/map -classpath build/classes/map src/map/*

run: mapa
	java -classpath build/classes/map:dist/lib/postgresql.jar map.Map $(A0) $(A1) $(A2) $(A3) $(A4) $(A5)

clean:
	rm -rf build/classes/map/* *~ src/*~ src/map/*~


