########################################################################################
#  Para fazer o make run do programa sao necessarios 6                                  #
#  args, host, nomebasedados, user, password, replica e opcao. Para correr basta fazer:  #
#  make run A1="host" A2="nomebd" A3="user" A4="pw" A5="replica" A6="opcao"             #
#  Usar um dos 2 exemplos mais abaixo neste ficheiro       				 #
##########################################################################################

make run A0="localhost" A1="so2" A2="l29263" A3="passwordrjcf" A4="1" ,"2" ou "3" A5="1" ou "2"

A replica pode ser a 1, a 2 ou 3.
A opcao e 1 ou 2, sendo a 1 a escrita do hash no ficheiro .txt e a opcao 2 a verificacao de integridade.
		      ou

make run A0="localhost" A1="l29764" A2="l29764" A3="so2" A4="1" ,"2" ou "3" A5="1" ou "2"


**Caso seja necessario criar as tabelas na base de dados encontra-se o ficheiro mydb.sql na pasta do programa(.../Map/)

