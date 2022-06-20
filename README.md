# consulta_cnpj

## Versão do aplicativo
Aplicativo desenvolvido versão 1.0.0

## Requisitos de versionamento
Flutter 2.10.5 - channel stable
Dart 2.16.2

## Objetivo
O aplicativo Consulta CNPJ serve para o usuário consultar o CNPJ de uma determinada empresa e retornar algumas informações sobre a mesma.

## Como funciona
Ao entrar no aplicativo, será solicitado o CNPJ da empresa que o usuário deseja buscar e será retornado as informações:
* Nome
* Fantasia
* CNPJ
* Situação
* Data da situação
* Motivo da situação

Para realizar consulta de outro CNPJ basta utilizar o botão disponível na tela em que foi retornado as informações.

A consulta é realizada na API da Receita Federal disponibilizada gratuitamente.
API: 

## Informações adicionais

Será possível realizar apenas 3 consultas a cada minuto. Caso ultrapasse esse limite, o aplicativo irá alertar.