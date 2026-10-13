
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

echo "Regras iniciais do firewall configuradas."
