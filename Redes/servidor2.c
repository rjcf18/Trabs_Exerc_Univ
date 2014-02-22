#include <stdio.h>
#include <string.h>
#include <unistd.h>

#ifdef unix			// se o SO for linux/unix
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#else				// se o SO for windows
#include <winsock2.h>
WSADATA wsa_data;
#endif

typedef struct Login{
	char l[2048];
	char p[2048];
	char t[2048];
}Login;

typedef struct Conta
{
	char cliente[2048];
	int saldo;
	int nr_conta;
}Conta;

typedef struct Movimentos{
	char movimento[2048];
	int valor;
}Movimentos;

typedef struct Servicos{
	char entidade[2048];
	char servico[2048];
}Servicos;

void accoes(msg){
	switch (msg){
		case "1":
			printf("####################");
			printf("###### Contas ######");
			printf("####################");
		case "2":
			// criar objecto struct conta com saldo = 1000€
		case "3":
			printf("Saldo da conta: ");
			
		case "4":
		case "5":
		case "6":
		case "7":
		case "8":
		case "9":
		case "10":
		case "11":
		case "12":
		case "13":
		case "14":
		case "15":
	}
}


main() {
	#ifndef unix 	// se o SO for windows
	WSAStartup(MAKEWORD(2, 0), &wsa_data);
	#endif
	
	struct sockaddr_in cliente; // preciso de outro para o cliente
		
	// Definição e população da estructura sockaddr_in -------------------------
	struct sockaddr_in servidor;	
	memset(&(servidor.sin_zero),0, sizeof(servidor.sin_zero));
	servidor.sin_family = AF_INET;
	servidor.sin_addr.s_addr = htonl(INADDR_ANY);
	servidor.sin_port = htons(2000); //servidor na porta 2000 
	
	//criar o socket	--------------------------------------------------------
	int sock = socket(AF_INET,SOCK_STREAM,0);
	
	//fazer o bind	------------------------------------------------------------
	int bindResult = bind(sock, (struct sockaddr *) &servidor, sizeof(servidor));
	if (bindResult==-1) // verifica se houve erros no bind
		printf("Bind: Falhou!\n");
	else
		printf("Bind: ok!\n"); 

	// fazer o listen com uma fila de 1 cliente no máximo ----------------------
	int tamanho_fila = 1;
	if (listen(sock,tamanho_fila) == -1)  // verifica se o listen falhou
		printf("Listen: Falhou!\n");
	else 
		printf("Listen: ok!\n");
	
	int size = 15;
	Login listaLogin[size];
	int apont=0;
	
	Conta listaConta[size];
	int apont1=0;
	
	Movimentos listaMov[size];
	int apont2=0;
	
	char mensagemRecebida[2048];	// variável para guardar o que é lido do socket
	char mensagemResposta[2048];	// variável para guardar o que é lido do socket
	int nbytes;				// guarda o número de bytes da mensagem lida
	int tamanho_cliente;	// guarda o tamanho da estructura do cliente
	int sock_aceite;		// guarda socket aceite
	
	tamanho_cliente = sizeof(struct sockaddr_in); //por imposição do accept temos que fazer isto

	while(1) {				// o servidor vai estar sempre a correr
		
		// fica à espera que um cliente se ligue
		sock_aceite = accept(sock, (struct sockaddr *)&cliente, &tamanho_cliente);
		
		int cena;
		if (sock_aceite>-1) {	//se recebeu um cliente
			//mostra informações do cliente
			printf("Recebida uma ligacao do cliente IP: %s\n",inet_ntoa(cliente.sin_addr));
			int verifica = 1;
			while (verifica==1)
			{
				int cena;
				nbytes = recv(sock_aceite, mensagemRecebida,sizeof(mensagemRecebida)+1, 0);
				printf("2-A escolha foi: %s \n",mensagemRecebida);
				int esc = strcmp(mensagemRecebida,"1");
				if(esc==-48)
				{
					if(nbytes>0)
					{
						strcpy(mensagemResposta, "Está no Login");
						send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
						printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
					}
					nbytes = recv(sock_aceite, mensagemRecebida,sizeof(mensagemRecebida)+1, 0);
					printf("2-Mensagem Recebida: %s \n",mensagemRecebida);
					if (nbytes>0) 
					{
						int i;
						for(i=0;i<=size;i++)
						{
							int result=strcmp(mensagemRecebida,listaLogin[i].l);
							if(result==0)
							{
								strcpy(mensagemResposta, "Aceite");
								send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
								printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
								cena = i;
								break;	
							}
							if(i==4)
							{
								strcpy(mensagemResposta, "Negado");
								send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
								printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
								cena = i;
							}
						}
					}
					nbytes = recv(sock_aceite, mensagemRecebida,sizeof(mensagemRecebida)+1, 0);
					printf("2-Mensagem Recebida: %s \n",mensagemRecebida);
					if(nbytes>0)
					{
						int res = strcmp(mensagemRecebida,listaLogin[cena].p);
						if(res == 0)
						{
							strcpy(mensagemResposta, listaLogin[cena].t);
							send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
							printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
							
							nbytes = recv(sock_aceite, mensagemRecebida,sizeof(mensagemRecebida)+1, 0);
							printf("2-Mensagem Recebida: %s \n",mensagemRecebida);
							if(nbytes>0)
							{
								/*int i;
								char c;
								for(i=1;i<=15;i++)
								{
									c = i;
									int op = strcmp(mensagemRecebida,c);
									if(op==0)
									{
										break;
									}
								}*/
								//acess(c);
								
								strcpy(mensagemResposta, "Acção efectuada com sucesso");
								send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
								printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
							}
						}
						else
						{
							strcpy(mensagemResposta, "Login Negado");
							send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
							printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
						}
					}
				}
				else
				{
					if(nbytes>0)
					{
						strcpy(mensagemResposta, "Está no Registo");
						send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
						printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
					}
					nbytes = recv(sock_aceite, mensagemRecebida,sizeof(mensagemRecebida)+1, 0);
					printf("2-Mensagem Recebida: %s \n",mensagemRecebida);
					if (nbytes>0) 
					{
						strcpy(listaLogin[apont].l,mensagemRecebida);
						strcpy(mensagemResposta, "LoginC");
						send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
						printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
						printf("%s\n",listaLogin[apont].l);
					}
					nbytes = recv(sock_aceite, mensagemRecebida,sizeof(mensagemRecebida)+1, 0);
					printf("2-Mensagem Recebida: %s \n",mensagemRecebida);
					if(nbytes>0)
					{
						strcpy(listaLogin[apont].p,mensagemRecebida);
						strcpy(mensagemResposta, "PasswordC");
						send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
						printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
					}
					nbytes = recv(sock_aceite, mensagemRecebida,sizeof(mensagemRecebida)+1, 0);
					printf("2-Mensagem Recebida: %s \n",mensagemRecebida);
					if(nbytes>0)
					{
						strcpy(listaLogin[apont].t,mensagemRecebida);
						strcpy(mensagemResposta, "Registo Concluído");
						send(sock_aceite, mensagemResposta,strlen(mensagemResposta)+1, 0);
						printf("3-Resposta enviada para o cliente: %s \n", mensagemResposta);
						//printf("%s, %s, %s\n",listaLogin[apont].l,listaLogin[apont].p,listaLogin[apont].t);
						apont++;
					}
				}
			}
		}
	}
}
