# Backend - Música Dstribuída

Trabalho final da disciplina de Sistemas Distribuídos na Universidade Federal Fluminense.

Para iniciar o servidor:

1. Dentro da pasta `public` (dentro de `src`), coloque os arquivos .mp3 que você deseja distribuir (os originais foram omitidos do repositório por questões legais, com exceção do `example.mp3`).
2. Instale o Docker (e o Docker Compose) na sua máquina. Se já tiver instalado, pule esse passo.
3. Com o Docker e Docker Compose instalados, rode `docker-compose up` e o backend será configurado, junto com a base de dados com os metadados das músicas que você tiver colocado em `public`.
4. Acesse a API usando o IP da sua máquina, na porta 3000. São só duas rotas: 
    * GET /get-all-mp3: Retorna todas as informações de todas as músicas presentes na pasta `public`;
    * GET /stream-mp3/:id: Retorna o arquivo .mp3 com o id especificado no banco. Em navegadores, isso inicia um stream do arquivo.

Obs.: Se quiser distribuir suas músicas para fora da sua rede local, você precisará abrir uma porta no seu roteador. [Aqui tem um tutorial geral de como fazer isso.](https://suporte.topdata.com.br/suporte/como-configurar-o-redirecionamento-de-porta-em-um-modem-ou-roteador/)
