#!/bin/sh

# Encerra o script caso algum comando apresente erro.
set -e

# Remove regras anteriores de encaminhamento.
iptables -F FORWARD

# Bloqueia por padrao os pacotes encaminhados entre redes.
iptables -P FORWARD DROP

# Permite respostas de conexoes ja autorizadas.
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Permite que funcionarios acessem o servidor web da empresa.
iptables -A FORWARD -s 172.30.10.0/24 -d 172.30.20.10 -p tcp --dport 80 -j ACCEPT


# Identifica a interface de saida para a internet.
WAN_IFACE=$(ip -4 route show default | awk 'NR==1 {print $5}')

# Verifica se o endereco autorizado foi informado.
if [ -z "${SUAP_IP:-}" ] || [ -z "$WAN_IFACE" ]; then
    echo "Erro: IP do SUAP ou interface WAN nao configurados."
    exit 1
fi

# Permite que as respostas da internet retornem ao cliente.
iptables -t nat -A POSTROUTING \
    -s 172.30.10.0/24 \
    -o "$WAN_IFACE" \
    -j MASQUERADE

# Autoriza acesso HTTPS ao IP selecionado do SUAP.
iptables -A FORWARD \
    -s 172.30.10.0/24 \
    -d "$SUAP_IP" \
    -o "$WAN_IFACE" \
    -p tcp --dport 443 \
    -j ACCEPT



echo "Regras iniciais do firewall configuradas."


exec "$@"
