# Flutter Checklist

## PocketBase

- Instalar o Pocketbase na pasta backend, na raiz do projeto
- Rode o comando `./pocketbase serve` e faça as configurações no navegador
- Sempre precisará rodar o Pocketbase antes de inicializar o projeto Flutter.

Se você for testar no Android Emulator, conecte com o endereço `10.0.2.2`, senão pode deixar `127.0.0.1` para Desktop ou Web. Se for usar um Android Físico, irá precisar acessar o Pocketbase via rede local, então use o comando `./pocketbase serve --http="IP:8090"`, onde `IP` é o seu IP Local:
- Executar `ipconfig` (Windows) ou 
- `ifconfig | grep "inet " | grep -v 127.0.0.1`

## MockAPI 

Para testar a integração à API no Backend com `http`, usamos o serviço `https://mockapi.io` que é gratuito até 2 recursos e funciona bem para o teste de requisições HTTP POST, GET, PUT, DELETE, etc., retornando ou recebendo dados em JSON. 