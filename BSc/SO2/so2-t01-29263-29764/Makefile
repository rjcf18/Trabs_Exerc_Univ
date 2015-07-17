all: database
	CLASSPATH=classes:. javac -d classes src/*.java

stubs:
	CLASSPATH=classes:. rmic -vcompat -d classes src.ReservasEspacosImpl


# activar o servico de nomes:
reg:
	 rmiregistry -J-classpath -Jclasses:. 9000

rs:
	java -classpath classes:lib/postgresql.jar src.ReservasEspacosServer 9000 $(A1) $(A2) $(A3) $(A4) 

rc:
	CLASSPATH=classes:. java src.ReservasEspacosClient alunos.di.uevora.pt 9000

# base de dados
database: classes/src/BD.class

runjdbc: classes/src/BD.class
	echo " **** falta adicionar o driver PG a classpath **** "
	java -classpath classes:lib/postgresql.jar src/BD $(A0) $(A1) $(A2) $(A3)

classes/src/BD.class: src/BD.java
	javac -classpath .:classes/src -d classes src/BD.java

clean:
	rm -rf classes/* *~ src/*~ src/so2/*~ src/so2/rmi/*~
