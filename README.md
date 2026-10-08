# Controle de Acesso a Sites em Ambiente Corporativo

## Projeto de Segurança da Informação

Instituição: Instituto Federal Goiano – Campus Ceres
Curso: Bacharelado em Sistemas de Informação
Disciplina: Segurança da Informação
Professor: Roitier Campos Gonçalves
Aluno: Arthur Henrique Dias Do Couto

## 1. Sobre o projeto

Este projeto tem como objetivo implementar uma solução de controle de acesso à internet em um ambiente corporativo simulado, utilizando Docker, Docker Compose e Firewall Linux com Iptables.
A proposta consiste em demonstrar como uma empresa pode estabelecer regras de segurança para controlar o tráfego de sua rede interna, permitindo o acesso a serviços necessários ao trabalho e restringindo o acesso a determinados sites de entretenimento e redes sociais.
Entre os exemplos de plataformas que se pretende restringir estão Netflix, Instagram e TikTok.

## 2. Situação-problema

O projeto considera uma empresa fictícia do setor de serviços administrativos, na qual os funcionários utilizam computadores conectados à internet para realizar suas atividades diárias.
A empresa não possui políticas de rede adequadas para controlar o acesso a determinados serviços externos. Dessa forma, os computadores corporativos podem ser utilizados para acessar plataformas de streaming e redes sociais durante o expediente.
Além da utilização de recursos da rede para atividades não relacionadas ao trabalho, a ausência de regras de acesso dificulta o controle das conexões e a proteção dos serviços internos.
Diante desse cenário, propõe-se a implementação de um firewall para controlar a comunicação entre as redes e estabelecer restrições de acesso.
