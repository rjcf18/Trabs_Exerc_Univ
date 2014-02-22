#include <stdio.h>
#include <string.h>
#include <unistd.h>

#ifdef unix		// se o SO for linux/unix
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#else				// se o SO for windows
#include <winsock2.h>
WSADATA wsa_data;
#endif

char username[2048];
char password[2048];
char userR[2048];
char passR[2048];
char tipoUti[2048];
int escolha;
char opcao[3];

void menu()
{
	printf("\t=============================================\n");
	printf("\t= 1 - Login \n\t= 2 - Registo\n");
	printf("\t=============================================\n\n");
	scanf("%d", &escolha);
	switch(escolha)
	{
		case 1:
		{
			printf("Insira Login:");
			scanf("%s",&username);
			printf("Insira Password:");
			scanf("%s",&password);
			break;
		}
		case 2:
		{
			printf("Qual o nome de utilizador que pretende?");
			scanf("%s",&userR);
			printf("Qual a password que pretende?");
			scanf("%s",&passR);
			printf("Qual o tipo de utilizador que pretende?\n1 - Cliente\n2 - Entidade\n3 - Administrador\n");
			scanf("%s",&tipoUti);
			break;
		}
		default:
		{
			printf("Escolha uma das opções");
			menu();
			break;
		}	
	}
}

main() 
{

	#ifndef unix	// se o SO for windows
	WSAStartup(MAKEWORD(2, 0), &wsa_data);
	#endif
	
	//criar o socket	--------------------------------------------------------
	int sock = socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);
	
	// Definição e população da estructura sockaddr_in -------------------------
	struct sockaddr_in server;
	memset(&(server.sin_zero),0, sizeof(server.sin_zero));
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = inet_addr("127.0.0.1");	//define o IP
	server.sin_port = htons(2000);						//define a porta [1012-65535]
	
	char mensagemEnvio[2048];	// variável para guardar o que é escrito do socket
	char mensagemResposta[2048];
	char mensagemEnviop[2048];
	
	int resultado = connect(sock, (struct sockaddr *)&server,sizeof(server));
	
	if (resultado==-1)
		printf("servidor nao encontrado!");
	else 
	{
		int verifica = 1;
		while (verifica==1)
		{
			menu();
			strcpy(mensagemEnvio,&escolha);
			send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
			printf("1-Mensagem enviada para o Server: %s \n", mensagemEnvio);
			
			recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
			printf("4-Resposta recebida do Server: %s \n", mensagemResposta);
			if(escolha==1)
			{
				strcpy(mensagemEnvio,username);
				send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
				printf("1-Mensagem enviada para o Server: %s \n", mensagemEnvio);
			
				recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
				printf("4-Resposta recebida do Server: %s \n", mensagemResposta);
				int res = strcmp(mensagemResposta,"Aceite");
				if(res == 0)
				{
					strcpy(mensagemEnvio,password);
					send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
					printf("5-Mensagem enviada para o Server: %s \n", mensagemEnvio);
				
					recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
					printf("8-Resposta recebida do Server: %s \n", mensagemResposta);
					
					int res2 = strcmp(mensagemResposta,"1");
					int res3 = strcmp(mensagemResposta,"2");
					int res4 = strcmp(mensagemResposta,"3");
					if(res2==0)
					{
						printf("Qual a opção que pretende?\n");
						printf("1 - Listar Contas\n2 - Criar Conta\n3 - Consulta de Saldo de Conta\n\
4 - Consulta de Movimento de uma conta\n5 - Consulta de Saldo Integrado\n6 - Movimento Entre Próprias Contas\n\
7 - Apagar Conta\n8 - Listagem de Serviço de Pagamentos\n9 - Efectuar Pagamento de Serviços\n");
						scanf("%s",&opcao);
						
						strcpy(mensagemEnvio,&opcao);
						send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
						printf("5-Mensagem enviada para o Server: %s \n", mensagemEnvio);
				
						recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
						printf("8-Resposta recebida do Server: %s \n", mensagemResposta);
					}
					if(res3==0)
					{
						printf("Qual a opção que pretende?\n");
						printf("1 - Listar Contas\n2 - Criar Conta\n3 - Consulta de Saldo de Conta\n\
4 - Consulta de Movimento de uma conta\n5 - Consulta de Saldo Integrado\n6 - Movimento Entre Próprias Contas\n\
7 - Apagar Conta\n8 - Listagem de Serviço de Pagamentos\n10 -Criação de Um Novo Serviço\n");
						scanf("%s",&opcao);
						
						strcpy(mensagemEnvio,&opcao);
						send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
						printf("5-Mensagem enviada para o Server: %s \n", mensagemEnvio);
				
						recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
						printf("8-Resposta recebida do Server: %s \n", mensagemResposta);
					}
					if(res4==0)
					{
						printf("Qual a opção que pretende?\n");
						printf("8 - Listagem de Serviço de Pagamentos\n11 - Lista de Todos os Cliente e Respectivos Saldos\n\
12 - Lista de todas as Entidades e Respectivos Saldos\n13 - Valor Total Depositado no Banco\n\
14 - Congelar Conta\n15 - Descongela Conta");
						scanf("%s",&opcao);
						
						strcpy(mensagemEnvio,&opcao);
						send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
						printf("5-Mensagem enviada para o Server: %s \n", mensagemEnvio);
				
						recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
						printf("8-Resposta recebida do Server: %s \n", mensagemResposta);
					}
				}
			}
			else
			{
				strcpy(mensagemEnvio,userR);
				send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
				printf("1-Mensagem enviada para o Server: %s \n", mensagemEnvio);
			
				recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
				printf("4-Resposta recebida do Server: %s \n", mensagemResposta);
				int res = strcmp(mensagemResposta,"LoginC");
				if(res == 0)
				{
					strcpy(mensagemEnvio,passR);
					send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
					printf("5-Mensagem enviada para o Server: %s \n", mensagemEnvio);
				
					recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
					printf("8-Resposta recebida do Server: %s \n", mensagemResposta);
					
					int res1 = strcmp(mensagemResposta,"PasswordC");
					if(res1 == 0)
					{
						strcpy(mensagemEnvio,tipoUti);
						send(sock, mensagemEnvio,strlen(mensagemEnvio)+1, 0);
						printf("5-Mensagem enviada para o Server: %s \n", mensagemEnvio);
						
						recv(sock, mensagemResposta,sizeof(mensagemResposta)+1, 0);
						printf("8-Resposta recebida do Server: %s \n", mensagemResposta);
					}
				}			
			}
		}
	}
	close(sock);
}
