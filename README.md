# Controle de Acesso a Sites em Ambiente Corporativo

**Projeto de Segurança da Informação**

**Instituição:** Instituto Federal Goiano - Campus Ceres  
**Curso:** Bacharelado em Sistemas de Informação  
**Disciplina:** Segurança da Informação  
**Professor:** Roitier Campos Gonçalves  
**Aluno:** Arthur Henrique Dias Do Couto

---

## 1. Sobre o Projeto

Este projeto apresenta a implementação de uma solução de controle de acesso à internet em um ambiente corporativo fictício, utilizando Firewall Linux, Iptables e Docker Compose.

A proposta surgiu da necessidade de estabelecer políticas de utilização dos computadores de uma empresa, restringindo conexões a determinados serviços de entretenimento e redes sociais durante as atividades profissionais.

O objetivo não é proibir o entretenimento ou limitar a liberdade dos funcionários fora do ambiente de trabalho, mas garantir que os equipamentos e recursos tecnológicos disponibilizados pela organização sejam utilizados de acordo com suas finalidades.

Para isso, foi desenvolvida uma infraestrutura de rede simulada, permitindo a aplicação e a validação de regras de segurança responsáveis por controlar o tráfego entre diferentes redes e restringir conexões a destinos não autorizados.

A solução utiliza uma política de bloqueio por padrão, na qual somente os acessos explicitamente autorizados são permitidos.

## 2. Situação-Problema

A **ValeGest Serviços Administrativos** é uma empresa fictícia voltada à prestação de serviços administrativos, organização documental e gerenciamento de processos empresariais.

A organização possui políticas internas rigorosas quanto à utilização dos equipamentos corporativos, buscando garantir que seus recursos tecnológicos sejam destinados prioritariamente às atividades profissionais.

Durante uma avaliação interna fictícia, a administração identificou que alguns funcionários estavam utilizando os computadores corporativos para acessar plataformas de entretenimento e redes sociais, como Netflix, Instagram e TikTok, em momentos destinados à realização das atividades profissionais.

A situação chamou a atenção da gestão, uma vez que o uso frequente dessas plataformas poderia contribuir para a dispersão durante o expediente, além de utilizar recursos da infraestrutura de rede para finalidades não relacionadas às atividades da organização.

A análise também identificou que a empresa não possuía mecanismos técnicos de controle capazes de estabelecer restrições de acesso a determinados destinos na internet.

Dessa maneira, mesmo existindo orientações internas sobre a utilização adequada dos equipamentos, não havia uma infraestrutura de segurança que permitisse aplicar essas políticas diretamente no tráfego da rede.

É importante destacar que a ValeGest não considera o entretenimento uma prática negativa. A preocupação da organização está relacionada à utilização dos recursos corporativos, que devem permanecer disponíveis para as necessidades operacionais da empresa.

Diante desse cenário, surgiu a necessidade de implementar uma solução capaz de controlar o acesso a determinados serviços externos, sem comprometer a comunicação com sistemas e plataformas necessários ao trabalho.

A proposta consiste na utilização de um firewall Linux para estabelecer regras de acesso, permitindo conexões autorizadas e restringindo destinos que não fazem parte das atividades administrativas.

## 3. Arquitetura e Proposta de Solução

A infraestrutura foi desenvolvida utilizando containers Docker, organizados por meio do Docker Compose.

O ambiente representa uma rede corporativa segmentada, contendo uma estação de trabalho, um firewall e um servidor web empresarial.

### 3.1 Componentes da infraestrutura

| Componente | Descrição |
|---|---|
| Cliente | Simula o computador de um funcionário da ValeGest |
| Firewall | Controla o encaminhamento e a filtragem dos pacotes |
| Site-empresa | Servidor web Nginx localizado na DMZ |

### 3.2 Redes utilizadas

A infraestrutura possui três redes virtuais com funções distintas.

**LAN (Local Area Network):** representa a rede interna utilizada pelos funcionários.

**DMZ (Zona Desmilitarizada):** representa a rede destinada aos serviços corporativos, contendo o servidor web Nginx.

**WAN (Wide Area Network):** representa a conexão externa, utilizada para testar a comunicação com serviços disponíveis na internet.

O tráfego controlado entre essas redes é encaminhado pelo container firewall, onde são aplicadas as regras Iptables.

### 3.3 Endereçamento IP

| Componente | Endereço |
|---|---|
| Rede LAN | 172.30.10.0/24 |
| Cliente | 172.30.10.10 |
| Firewall na LAN | 172.30.10.2 |
| Rede DMZ | 172.30.20.0/24 |
| Firewall na DMZ | 172.30.20.2 |
| Servidor corporativo | 172.30.20.10 |
| SUAP, IP utilizado nos testes | 200.18.168.100 |

O endereço IP utilizado para acessar o SUAP pode ser alterado pelo serviço externo, sendo necessário verificar sua disponibilidade antes de realizar novos testes.

### 3.4 Matriz de Regras de Segurança

A política de segurança foi desenvolvida considerando o princípio de negação por padrão, no qual conexões não autorizadas são bloqueadas.

| Origem | Destino | Porta/Protocolo | Ação | Justificativa |
|---|---|---|---|---|
| LAN | Servidor corporativo | TCP 80 | ACCEPT | Permitir acesso ao serviço da empresa |
| LAN | DMZ, portas não autorizadas | Demais portas | DROP | Restringir conexões não autorizadas |
| LAN | SUAP (200.18.168.100) | TCP 443 | ACCEPT | Permitir acesso ao serviço institucional |
| LAN | Demais destinos externos | Tráfego não autorizado | DROP | Aplicar a política corporativa |
| Conexões estabelecidas | Tráfego de resposta | Conforme conexão | ACCEPT | Permitir o retorno de comunicações autorizadas |

O Iptables é responsável pela aplicação dessas regras, utilizando endereços IP, protocolos, portas e estados de conexão.

Não foram implementadas ferramentas de bloqueio DNS.

## 4. Execução e Validação do Projeto

### 4.1 Pré-requisitos

Para executar o ambiente desenvolvido para a ValeGest Serviços Administrativos, são necessárias as seguintes ferramentas:

- Docker Desktop com suporte a containers Linux;
- Docker Compose;
- Git, para clonar o repositório;
- Terminal PowerShell, para executar os comandos apresentados.

O projeto utiliza containers Alpine Linux, um servidor web Nginx e regras Iptables para controlar o tráfego entre as redes.

### 4.2 Configuração do endereço autorizado

O projeto utiliza a variável `SUAP_IP` para informar ao firewall o endereço externo que deverá receber permissão de acesso HTTPS.

Na pasta principal do projeto, deve existir um arquivo chamado `.env` com a seguinte configuração:

```dotenv
SUAP_IP=200.18.168.100
```

O endereço apresentado corresponde ao utilizado durante os testes documentados.

Caso o IP atual do SUAP seja diferente, será necessário atualizar o valor no arquivo `.env` antes de iniciar o ambiente.

O IP pode ser consultado pelo PowerShell:

```powershell
Resolve-DnsName suap.ifgoiano.edu.br -Type A
```

Essa consulta apenas identifica um endereço do serviço. O mecanismo de bloqueio e permissão permanece sendo o Iptables.

### 4.3 Inicialização do ambiente

Após clonar o repositório do GitHub, é necessário abrir a pasta do projeto no terminal.

**Verificar a configuração do Docker Compose:**

```powershell
docker compose config -q
```

Esse comando verifica se o arquivo `compose.yaml` possui uma estrutura válida. Caso esteja correto, não será apresentada nenhuma mensagem de erro.

**Construir as imagens e iniciar os containers:**

```powershell
docker compose up -d --build
```

O comando constrói as imagens personalizadas do cliente e do firewall e inicia os serviços configurados.

Durante a inicialização, o script `entrypoint.sh` do firewall é executado automaticamente, carregando as regras de segurança.

**Verificar os containers:**

```powershell
docker compose ps
```

O resultado esperado é a presença de três serviços em execução:

| Serviço | Função |
|---|---|
| cliente | Representa o computador de um funcionário |
| firewall | Controla o tráfego entre as redes |
| site-empresa | Representa o servidor corporativo na DMZ |

**Verificar a inicialização do firewall:**

```powershell
docker compose logs --tail=20 firewall
```

O resultado deverá apresentar a mensagem:

```text
Regras iniciais do firewall configuradas.
```

### 4.4 Verificação das configurações de rede

Antes de realizar os testes de acesso, é importante verificar o roteamento dos containers.

**Consultar as rotas do cliente:**

```powershell
docker compose exec cliente route -n
```

O cliente deverá utilizar o endereço `172.30.10.2` como gateway padrão, encaminhando o tráfego destinado a outras redes para o firewall.

**Consultar as rotas do servidor:**

```powershell
docker compose exec site-empresa route -n
```

O servidor deverá utilizar o endereço `172.30.20.2` para alcançar a LAN.

**Verificar o encaminhamento IPv4:**

```powershell
docker compose exec firewall cat /proc/sys/net/ipv4/ip_forward
```

O resultado esperado é `1`, indicando que o encaminhamento de pacotes IPv4 está habilitado.

### 4.5 Verificação das regras do Firewall

Para consultar as regras configuradas no Iptables, utiliza-se:

```powershell
docker compose exec firewall iptables -L FORWARD -n -v --line-numbers
```

Esse comando apresenta a política padrão da cadeia FORWARD, as regras ACCEPT configuradas e os contadores de pacotes e bytes.

A política padrão deverá aparecer como `DROP`, indicando que pacotes encaminhados sem autorização explícita serão descartados.

## 5. Metodologia de Testes

Os testes foram realizados a partir dos containers Docker, simulando tentativas de comunicação autorizadas e não autorizadas.

Para cada situação, foram observadas as respostas dos serviços e os contadores de pacotes do Iptables.

### 5.1 Teste de acesso permitido ao servidor corporativo

O primeiro teste verifica se o computador do funcionário consegue acessar o servidor web da ValeGest pela porta HTTP autorizada.

**Comando:**

```powershell
docker compose exec cliente wget -T 8 -O- http://172.30.20.10
```

**Resultado esperado:** exibição do código HTML da página padrão do Nginx, contendo a mensagem `Welcome to nginx!`.

Para confirmar que o acesso foi autorizado pelo firewall, utiliza-se:

```powershell
docker compose exec firewall iptables -L FORWARD -n -v --line-numbers
```

A regra ACCEPT referente ao endereço `172.30.20.10`, na porta TCP 80, deverá registrar os pacotes correspondentes à conexão.

**Evidências:** `01-acesso-permitido` e `02-regras-accept`.

### 5.2 Teste de bloqueio de porta não autorizada

O segundo teste verifica a restrição de acesso a uma porta não autorizada do servidor corporativo.

**Comando:**

```powershell
docker compose exec cliente wget -T 5 -O- http://172.30.20.10:81
```

O cliente tenta acessar a porta TCP 81, que não possui uma regra de liberação.

**Resultado esperado:** falha na conexão por timeout.

Para confirmar o bloqueio, consulta-se novamente:

```powershell
docker compose exec firewall iptables -L FORWARD -n -v --line-numbers
```

O aumento do contador da política DROP, associado à tentativa, evidencia que os pacotes foram descartados pelo firewall.

**Evidências:** `03-acesso-bloqueado` e `04-regras-drop`.

### 5.3 Teste de restrição de acesso externo

Para verificar a restrição a serviços de entretenimento, foi utilizado um endereço IPv4 associado ao domínio da Netflix.

**Consultar o endereço IPv4 pelo PowerShell:**

```powershell
Resolve-DnsName www.netflix.com -Type A
```

Durante a execução documentada, foi selecionado o endereço `207.45.73.1`.

**Testar a conexão com o endereço selecionado:**

```powershell
docker compose exec cliente curl -4 -I -v --noproxy "*" --connect-timeout 5 --max-time 8 --resolve "www.netflix.com:443:207.45.73.1" https://www.netflix.com/
```

O parâmetro `--resolve` permite realizar a tentativa de conexão utilizando diretamente o IP selecionado, preservando o nome do domínio na requisição HTTPS.

**Resultado esperado:** timeout, pois o destino não possui uma regra de acesso autorizado.

A confirmação do descarte pode ser realizada pelo comando:

```powershell
docker compose exec firewall iptables -L FORWARD -n -v --line-numbers
```

O contador da política DROP deve ser analisado antes e depois da tentativa.

O teste demonstra o bloqueio do IP selecionado e não garante o bloqueio integral de todos os endereços utilizados pela Netflix.

**Evidências:** `05-descobrindo-ipnetflix`, `06-bloqueio-ip-externo` e `07-regras-drop`.

### 5.4 Teste de acesso autorizado ao SUAP do IF Goiano

Para demonstrar a aplicação de permissões específicas, foi configurada uma regra liberando conexões HTTPS para o endereço IPv4 autorizado do SUAP.

Durante os testes, foi utilizado o endereço `200.18.168.100`.

**Consultar o IP atual do SUAP:**

```powershell
Resolve-DnsName suap.ifgoiano.edu.br -Type A
```

O endereço autorizado é definido na variável `SUAP_IP` do arquivo `.env`, utilizada pelo Docker Compose para configurar o firewall.

Caso o endereço IP tenha sido alterado, será necessário atualizar essa configuração e recriar o container firewall.

**Executar o teste de acesso:**

```powershell
docker compose exec cliente curl -4 -I -v --noproxy "*" --connect-timeout 8 --max-time 15 --resolve "suap.ifgoiano.edu.br:443:200.18.168.100" https://suap.ifgoiano.edu.br/
```

**Resultado obtido durante o desenvolvimento:**

```text
Connected to suap.ifgoiano.edu.br (200.18.168.100) port 443
SSL certificate verify ok.
HTTP/1.1 302 Found
Location: /accounts/login/?next=/
```

O código HTTP 302 demonstra que o servidor respondeu à requisição e direcionou o acesso para sua página de autenticação.

**Verificar a regra de permissão:**

```powershell
docker compose exec firewall iptables -L FORWARD -n -v --line-numbers
```

A regra ACCEPT destinada ao IP autorizado do SUAP, na porta TCP 443, deverá apresentar pacotes contabilizados após a conexão.

**Evidências:** `08-descobrindo-ipSuap`, `09-suap-permitido` e `10-iptables-suap`.

### 5.5 Confirmação da manutenção dos bloqueios

Após implementar a regra de acesso ao SUAP, foi realizada uma nova tentativa de conexão com o endereço externo selecionado da Netflix.

O objetivo foi verificar se a autorização específica não havia comprometido a política geral de bloqueio.

**Comando:**

```powershell
docker compose exec cliente curl -4 -I -v --noproxy "*" --connect-timeout 5 --max-time 8 --resolve "www.netflix.com:443:207.45.73.1" https://www.netflix.com/
```

A tentativa deve continuar sendo bloqueada pela política DROP, uma vez que a regra de permissão foi criada exclusivamente para o destino autorizado.

**Evidência:** `11-confirmarbloqueio-netflix`.

### 5.6 Encerramento do ambiente

Para encerrar os containers e remover as redes criadas pelo Docker Compose, utiliza-se:

```powershell
docker compose down
```

Esse comando não exclui os arquivos do projeto nem as imagens construídas.

Para iniciar novamente:

```powershell
docker compose up -d --build
```

O projeto foi configurado para aplicar automaticamente as rotas e as regras Iptables durante a inicialização dos containers. O funcionamento deve ser conferido após reiniciar o ambiente.

## 6. Testes e Resultados Obtidos

Após a configuração da infraestrutura da ValeGest, foram realizados testes para verificar o funcionamento das políticas de segurança implementadas.

### 6.1 Acesso permitido ao servidor corporativo

Foi realizado um teste de comunicação entre o container cliente, localizado na LAN, e o servidor web Nginx, localizado na DMZ.

A conexão foi realizada utilizando o endereço `172.30.20.10`, pela porta TCP 80.

O servidor respondeu com a página padrão do Nginx, confirmando que a comunicação foi estabelecida.

Em seguida, foram consultadas as regras do Iptables, verificando-se que a regra ACCEPT correspondente ao acesso HTTP registrou o tráfego.

**Resultado:** Acesso autorizado e comunicação realizada com sucesso.

### 6.2 Bloqueio de acesso não autorizado

Para verificar a política de restrição, foi realizada uma tentativa de conexão com o mesmo servidor corporativo, utilizando a porta TCP 81.

Como essa porta não estava autorizada pelas regras configuradas, a conexão não foi estabelecida e apresentou timeout.

Posteriormente, a consulta ao Iptables permitiu verificar o descarte dos pacotes pela política padrão DROP.

**Resultado:** Conexão bloqueada conforme a política de segurança estabelecida.

### 6.3 Restrição de acesso a endereço externo associado à Netflix

Para simular a restrição de plataformas de entretenimento durante o expediente, foi selecionado um endereço IPv4 associado ao domínio da Netflix.

A consulta realizada durante o desenvolvimento retornou o endereço `207.45.73.1`, utilizado como destino do teste.

Após a identificação do IP, foi realizada uma tentativa de conexão a partir do container cliente.

A conexão foi impedida pela política de bloqueio do firewall, e os contadores do Iptables foram consultados para verificar o descarte dos pacotes.

É importante destacar que o procedimento demonstra o bloqueio de um endereço IP específico, não garantindo a restrição integral de todos os servidores utilizados pela Netflix.

**Resultado:** Conexão ao endereço externo selecionado bloqueada.

### 6.4 Liberação de acesso ao SUAP do IF Goiano

Para demonstrar que a infraestrutura permite o acesso a serviços autorizados, foi configurada uma regra específica para o SUAP do Instituto Federal Goiano.

Inicialmente, foi identificado o endereço IPv4 `200.18.168.100`, associado ao domínio `suap.ifgoiano.edu.br`.

Em seguida, foi implementada uma regra ACCEPT permitindo conexões HTTPS destinadas a esse endereço pela porta TCP 443.

O teste realizado com Curl confirmou que a conexão foi estabelecida com sucesso, incluindo a negociação TLS e a validação do certificado digital.

O servidor retornou o código HTTP `302 Found`, indicando o redirecionamento para a página de autenticação do SUAP.

A regra correspondente no Iptables também registrou pacotes, confirmando que a comunicação passou pelo firewall e foi autorizada.

**Resultado:** Acesso HTTPS ao SUAP autorizado e confirmado.

### 6.5 Confirmação do bloqueio após a liberação do SUAP

Após implementar a permissão de acesso ao SUAP, foi realizada uma nova verificação do bloqueio ao endereço externo anteriormente selecionado da Netflix.

O objetivo foi confirmar que a inclusão de uma regra de acesso autorizado não havia liberado indiscriminadamente os demais destinos da internet.

A tentativa de conexão permaneceu bloqueada, demonstrando que a política padrão DROP continuou sendo aplicada aos destinos sem autorização explícita.

**Resultado:** Restrição externa mantida após a implementação da permissão ao SUAP.

## 7. Organização das Evidências

Durante o desenvolvimento, foram produzidas 11 capturas de tela para documentar os procedimentos realizados e seus respectivos resultados.

Os arquivos estão organizados na pasta `Testes` deste repositório.

| Evidência | Descrição |
|---|---|
| 01-acesso-permitido | Acesso autorizado ao servidor corporativo |
| 02-regras-accept | Verificação dos contadores ACCEPT |
| 03-acesso-bloqueado | Tentativa de conexão pela porta 81 |
| 04-regras-drop | Comprovação do descarte de pacotes |
| 05-descobrindo-ipnetflix | Identificação do IP selecionado da Netflix |
| 06-bloqueio-ip-externo | Tentativa de acesso ao destino externo |
| 07-regras-drop | Verificação do bloqueio do destino externo |
| 08-descobrindo-ipSuap | Identificação do IP do SUAP |
| 09-suap-permitido | Acesso HTTPS autorizado ao SUAP |
| 10-iptables-suap | Regra ACCEPT do SUAP e contadores |
| 11-confirmarbloqueio-netflix | Revalidação do bloqueio externo |

As evidências permitem acompanhar os comandos executados, as respostas recebidas e o comportamento das regras de segurança implementadas.

## 8. Discussão dos Resultados

Os resultados demonstraram o funcionamento da infraestrutura desenvolvida para a empresa fictícia ValeGest Serviços Administrativos.

A segmentação das redes LAN e DMZ, combinada ao encaminhamento dos pacotes pelo container firewall, possibilitou a aplicação de regras de controle de acesso.

A política adotada foi baseada no bloqueio por padrão, permitindo apenas conexões previamente autorizadas.

O acesso ao servidor corporativo e ao SUAP demonstrou o funcionamento das regras ACCEPT, enquanto os testes realizados com portas e endereços externos não autorizados permitiram verificar a aplicação da política DROP.

A liberação do SUAP também demonstrou a possibilidade de estabelecer exceções específicas dentro da política corporativa, preservando conexões consideradas necessárias às atividades profissionais.

A solução foi implementada sem ferramentas de bloqueio DNS, utilizando o Iptables como principal mecanismo de filtragem.

Entretanto, o controle baseado em endereços IP apresenta limitações, especialmente em plataformas que utilizam múltiplos endereços ou infraestruturas distribuídas.

Assim, o bloqueio de um endereço associado a determinado serviço não representa necessariamente o bloqueio completo de toda a plataforma.

Os testes demonstram o funcionamento de uma política de restrição de conexões por IP e porta, aplicada a um ambiente corporativo simulado.

## 9. Considerações Finais

O desenvolvimento do projeto possibilitou a aplicação prática de conceitos relacionados à Segurança da Informação, segmentação de redes, roteamento, filtragem de pacotes e controle de acesso.

Por meio do Docker Compose, foi possível simular parte da infraestrutura tecnológica de uma empresa, utilizando containers para representar uma estação de trabalho, um firewall e um servidor corporativo.

A implementação do Iptables permitiu estabelecer uma política de segurança baseada no bloqueio por padrão e na liberação explícita de conexões autorizadas.

Os testes realizados demonstraram o acesso permitido ao servidor corporativo, o bloqueio de portas não autorizadas, a restrição de conexões externas e a liberação específica do acesso ao SUAP do IF Goiano.

No contexto da ValeGest Serviços Administrativos, a solução representa uma alternativa para organizar a utilização dos recursos tecnológicos da empresa e aplicar políticas internas de controle de acesso.

Conclui-se que a utilização de um firewall Linux, associada à segmentação de redes, contribui para o controle da comunicação entre diferentes ambientes, permitindo estabelecer regras de segurança de acordo com as necessidades da organização.

O projeto também evidencia a importância de compreender as limitações das técnicas utilizadas, especialmente quando aplicadas ao controle de serviços externos que possuem endereçamento dinâmico.

Dessa forma, o trabalho atende ao propósito de demonstrar, em um ambiente simulado, o funcionamento de políticas de segurança baseadas em Firewall Linux e Iptables.

---

**Instituto Federal Goiano - Campus Ceres**  
**Bacharelado em Sistemas de Informação**  
**Segurança da Informação, 2026**