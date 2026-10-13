# Controle de Acesso a Sites em Ambiente Corporativo

## Projeto de Segurança da Informação

Instituição: Instituto Federal Goiano – Campus Ceres
Curso: Bacharelado em Sistemas de Informação
Disciplina: Segurança da Informação
Professor: Roitier Campos Gonçalves
Aluno: Arthur Henrique Dias Do Couto

## 1. Sobre o projeto

Este projeto propõe a implementação de uma solução de controle de acesso à internet em um ambiente corporativo fictício, utilizando Firewall Linux, Iptables e Docker Compose.
A proposta surgiu da necessidade de estabelecer políticas de utilização dos computadores de uma empresa, restringindo o acesso a determinados serviços de entretenimento e redes sociais durante as atividades profissionais.
O objetivo não é proibir o entretenimento ou limitar a liberdade dos funcionários fora do ambiente de trabalho, mas garantir que os equipamentos e recursos tecnológicos disponibilizados pela organização sejam utilizados de acordo com suas finalidades.
Para isso, será desenvolvida uma infraestrutura de rede simulada, permitindo a aplicação e a validação de regras de segurança responsáveis por controlar o tráfego entre diferentes redes e restringir conexões a destinos não autorizados.

## 2. Situação-problema

Durante uma avaliação interna fictícia, a empresa identificou que alguns funcionários estavam utilizando os computadores corporativos para acessar plataformas de entretenimento e redes sociais, como Netflix, Instagram e TikTok, em momentos destinados à realização das atividades profissionais.
A situação chamou a atenção da gestão, uma vez que o uso frequente dessas plataformas poderia contribuir para a dispersão durante o expediente, além de utilizar recursos da infraestrutura de rede para finalidades não relacionadas às atividades da organização.
A análise também identificou que a empresa não possuía mecanismos técnicos de controle capazes de estabelecer restrições de acesso a determinados destinos na internet.
Dessa maneira, mesmo existindo orientações internas sobre a utilização adequada dos equipamentos, não havia uma infraestrutura de segurança que permitisse aplicar essas políticas diretamente no tráfego da rede.
É importante destacar que a empresa não considera o entretenimento uma prática negativa. A preocupação da organização está relacionada à utilização dos recursos corporativos, que devem permanecer disponíveis para as necessidades operacionais da empresa.
Diante desse cenário, surgiu a necessidade de implementar uma solução capaz de controlar o acesso a determinados serviços externos, sem comprometer a comunicação com sistemas e plataformas necessários ao trabalho.
