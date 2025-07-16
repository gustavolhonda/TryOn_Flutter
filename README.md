# TryOn Flutter

Aplicativo desenvolvido em Flutter para Aluguel de roupas.

## Membros

811773 - Jakson Huang Zheng

811716 - Gustavo Lamin Honda

## Como Buildar

1. Clone o repositório
2. Abra o projeto no Android Studio
3. Sincronize o projeto com os arquivos Gradle
4. Execute o emulador de celular
5. Selecione o emulador de celular como device 
6. Execute o programa usando o botão de Run verde na parte superior da IDE

## Como Testar

### Testes Unitários e Teste de banco de dados
Para executar os testes unitários e teste de banco de dados:
```
flutter test 
```
Lembre-se de estar rodando o backend na porta 3001 para os testes unitários de repositories

## Estrutura do Projeto

- `lib/main.dart` - Código fonte principal
- `test/repositories` - Testes unitários
- `test/database` - Testes de persistencia local

## Backend
1. Clone o repositório https://github.com/gustavolhonda/mocked-backend-tryon e siga as instruções do READ.ME
2. Rode ele localmente na porta 3001, assim o emulador consegue acessá-lo.
3. No back é feito a parte de login e a listagem de produtos.
