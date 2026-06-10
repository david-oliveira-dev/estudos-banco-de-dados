# Introdução a Banco de Dados

## 1. Ideia inicial

No dia a dia, precisamos armazenar e recuperar informações o tempo todo. Isso acontece quando usamos listas de telefones, cadernos de endereços, fichas de matrícula, planilhas, agendas, sistemas escolares ou arquivos digitais.

Guardar dados não basta. Também é necessário conseguir recuperar, consultar, alterar e excluir essas informações quando for preciso.

Um dado guardado sem organização ou sem possibilidade de recuperação perde grande parte de sua utilidade.

## 2. O que é um dado?

Um dado é um fato que pode ser registrado.

Exemplos de dados:

* nome de uma pessoa;
* endereço;
* RG;
* matrícula;
* curso;
* ano de ingresso;
* telefone;
* data de nascimento.

Sozinhos, esses dados podem parecer apenas informações soltas. Quando são organizados dentro de um contexto, passam a ter significado.

## 3. O que é um banco de dados?

Um banco de dados é uma coleção organizada de dados relacionados entre si.

Esses dados possuem significado e são armazenados com um objetivo específico.

Exemplo:

Uma ficha de matrícula de aluno pode conter:

* nome;
* endereço;
* RG;
* prontuário;
* curso;
* ano de ingresso.

Essas informações formam um conjunto organizado de dados sobre um aluno.

## 4. Características de um banco de dados

Um banco de dados possui algumas características importantes:

### 4.1 Coleção logicamente coerente

Os dados precisam fazer sentido entre si.

Um conjunto aleatório de informações não é considerado um banco de dados.

Exemplo de dados aleatórios:

```text
banana, 42, azul, cadeira, 900
```

Isso não forma um banco de dados, pois não há relação clara entre os dados.

Exemplo de dados organizados:

```text
Nome: Ana
Matrícula: 2024001
Curso: Informática
Ano de ingresso: 2024
```

Aqui existe contexto e significado.

### 4.2 Propósito específico

Um banco de dados é criado para atender a uma finalidade.

Exemplos:

* banco de dados escolar;
* banco de dados bancário;
* banco de dados de uma loja;
* banco de dados de uma biblioteca;
* banco de dados de pacientes em uma clínica.

Cada banco é criado para armazenar informações relevantes para determinado uso.

### 4.3 Representação de um minimundo

Um banco de dados representa uma parte restrita do mundo real. Essa parte é chamada de minimundo.

Exemplo:

Em uma escola, o minimundo pode envolver:

* alunos;
* professores;
* turmas;
* disciplinas;
* matrículas;
* notas.

O banco de dados não representa o mundo inteiro, apenas a parte da realidade que interessa para aquele sistema.

## 5. Operações realizadas em um banco de dados

Os usuários de um banco de dados precisam realizar operações sobre os dados armazenados.

As operações principais são:

* adicionar novos dados;
* consultar dados;
* atualizar dados;
* modificar a estrutura dos dados;
* excluir informações desnecessárias ou desatualizadas.

Essas operações permitem que o banco continue útil e atualizado.

## 6. O que é SGBD?

SGBD significa Sistema de Gerenciamento de Banco de Dados.

É um conjunto de programas que permite ao usuário:

* definir um banco de dados;
* construir um banco de dados;
* manipular um banco de dados.

Exemplos de SGBDs:

* PostgreSQL;
* MySQL;
* MariaDB;
* Oracle;
* SQL Server.

O SGBD é o software usado para controlar o banco de dados.

## 7. Objetivo de um sistema de banco de dados

O objetivo principal de um sistema de banco de dados é fornecer um ambiente adequado e eficiente para:

* armazenar informações;
* recuperar informações;
* organizar dados;
* manipular dados;
* manter os dados disponíveis para os usuários.

## 8. Banco de Dados, SGBD e SBD

É importante diferenciar os termos:

| Termo          | Significado                              |
| -------------- | ---------------------------------------- |
| Banco de Dados | Coleção organizada de dados relacionados |
| SGBD           | Software que gerencia o banco de dados   |
| SBD            | Banco de Dados + SGBD                    |

Assim:

```text
SBD = Banco de Dados + SGBD
```

## 9. Exemplo simples

Imagine um armário de aço com várias gavetas.

Cada gaveta guarda um tipo de documento, como fichas de alunos. Nesse armário, é possível:

* inserir uma nova ficha;
* consultar uma ficha;
* alterar uma ficha;
* excluir uma ficha.

Um banco de dados computacional funciona de maneira parecida, mas no computador e seguindo regras para tornar o armazenamento mais eficiente, seguro e organizado.

## 10. O que memorizar

* Banco de dados é uma coleção organizada de dados relacionados.
* Dados são fatos que podem ser registrados.
* Um conjunto aleatório de dados não é um banco de dados.
* Todo banco de dados possui um propósito específico.
* O minimundo é a parte da realidade representada pelo banco de dados.
* SGBD é o software que permite definir, construir e manipular um banco de dados.
* SBD é o conjunto formado pelo banco de dados e pelo SGBD.

## 11. Resumo final

Banco de dados é uma forma organizada de armazenar informações relacionadas, permitindo que elas sejam consultadas, modificadas, inseridas e removidas de maneira eficiente.

O SGBD é o sistema responsável por gerenciar esse banco, oferecendo recursos para que os usuários possam trabalhar com os dados de forma segura e organizada.

