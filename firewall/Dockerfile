# Utiliza o Alpine Linux como sistema base.
FROM alpine:3.22

# Instala as ferramentas para configurar e analisar a rede.
RUN apk add --no-cache iptables iproute2

# Copia o script de inicializacao para dentro da imagem.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Concede permissao de execucao ao script.
RUN chmod +x /usr/local/bin/entrypoint.sh
