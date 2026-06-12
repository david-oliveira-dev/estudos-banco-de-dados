# Usuários e Atores de um Banco de Dados

## 1. Ideia geral

Um banco de dados pode ser utilizado por diferentes tipos de usuários.

Cada usuário tem uma necessidade específica e um nível diferente de envolvimento com os dados.

Alguns usuários apenas consultam informações.  
Outros modificam dados.  
Alguns projetam a estrutura do banco.  
Outros administram permissões, segurança e desempenho.

Por isso, os usuários de um banco de dados podem ser classificados em diferentes categorias. :contentReference[oaicite:0]{index=0}

---

## 2. Administradores de Banco de Dados - DBA

DBA significa **Database Administrator**, ou seja, **Administrador de Banco de Dados**.

O DBA é o profissional responsável por administrar os recursos relacionados ao banco de dados.

Em uma organização, quando muitas pessoas compartilham recursos importantes, é necessário existir alguém responsável por supervisionar e gerenciar esses recursos.

No caso de banco de dados, o principal recurso é a própria base de dados. Também fazem parte desse ambiente o SGBD e os softwares relacionados.

---

## 3. Responsabilidades do DBA

O DBA é responsável por:

- autorizar o acesso à base de dados;
- coordenar o uso do banco;
- monitorar o funcionamento do banco;
- cuidar da segurança;
- acompanhar o desempenho;
- resolver problemas relacionados ao banco;
- gerenciar usuários e permissões;
- garantir que os dados estejam disponíveis de forma adequada.

Exemplo:

Se um usuário não autorizado consegue acessar informações confidenciais, isso pode indicar uma falha de segurança.  
Nesse caso, o DBA precisa atuar para corrigir permissões, revisar acessos e proteger o banco.

Outro exemplo:

Se o banco estiver muito lento, o DBA pode investigar o desempenho e buscar formas de melhorar o funcionamento.

Em grandes organizações, pode existir uma equipe inteira de DBAs.

---

## 4. Analistas de Banco de Dados ou Projetistas

Os analistas de banco de dados, também chamados de projetistas, são responsáveis por planejar a estrutura do banco.

Eles identificam quais dados precisam ser armazenados e escolhem a melhor forma de organizar esses dados.

Antes de criar as tabelas, é necessário entender o que o sistema precisa representar.

Exemplo em uma escola:

O analista precisa identificar que o banco deverá armazenar dados sobre:

- alunos;
- professores;
- turmas;
- disciplinas;
- notas;
- matrículas.

Depois, ele precisa definir como esses dados estarão estruturados e relacionados.

---

## 5. Função dos analistas/projetistas

Os analistas de banco de dados devem conversar com os usuários que utilizarão o sistema.

Cada grupo de usuários pode ter uma visão diferente dos dados.

Exemplo:

- a secretaria vê dados cadastrais;
- os professores veem notas e turmas;
- a coordenação vê relatórios pedagógicos;
- o financeiro vê dados de pagamento;
- a direção vê indicadores gerais.

O papel do analista é juntar essas diferentes visões e construir uma representação adequada do banco de dados.

Essa representação precisa atender aos requisitos dos diferentes grupos de usuários.

---

## 6. Usuários finais

Usuários finais são as pessoas que utilizam o banco de dados no dia a dia.

Eles não necessariamente conhecem a estrutura interna do banco nem sabem programar.

A base de dados existe principalmente para atender às necessidades desses usuários.

Os usuários finais podem:

- consultar dados;
- modificar informações;
- gerar relatórios;
- utilizar telas e sistemas conectados ao banco;
- acompanhar informações importantes para seu trabalho.

Exemplo em uma escola:

- professores consultam turmas e lançam notas;
- alunos visualizam boletins;
- funcionários da secretaria atualizam cadastros;
- coordenadores geram relatórios;
- gestores acompanham indicadores.

---

## 7. Tipos de usuários finais

Os usuários finais podem ter diferentes níveis de conhecimento e interação com o banco.

Alguns podem ser usuários comuns, que utilizam apenas telas prontas.

Outros podem ser usuários avançados, que fazem consultas mais elaboradas ou geram relatórios específicos.

Também podem existir analistas de negócios que usam os dados para apoiar decisões.

Exemplo:

Um funcionário comum pode buscar o cadastro de um aluno em uma tela do sistema.

Um analista pode usar consultas e relatórios para identificar padrões, como evasão, frequência ou desempenho.

---

## 8. Analistas de Sistemas

Os analistas de sistemas são responsáveis por entender as necessidades dos usuários finais.

Eles levantam requisitos e transformam essas necessidades em especificações para o sistema.

Exemplo:

Um usuário final pode dizer:

```text
Preciso gerar um relatório com todos os alunos de uma turma e suas notas.
```

O analista de sistemas transforma essa necessidade em uma especificação mais clara:

```text
O sistema deverá permitir filtrar alunos por turma, consultar suas notas e gerar um relatório em formato PDF.
```

Assim, o analista de sistemas funciona como uma ponte entre os usuários e a equipe técnica.

---

## 9. Programadores de Aplicações

Os programadores de aplicações são responsáveis por implementar os sistemas que usam o banco de dados.

Eles transformam as especificações feitas pelos analistas em programas reais.

Suas tarefas podem incluir:

- programar funcionalidades;
- criar telas;
- conectar a aplicação ao banco;
- testar o sistema;
- depurar erros;
- documentar o código;
- realizar manutenção;
- implementar consultas e operações no banco.

Exemplo:

Se o analista especifica uma tela de cadastro de alunos, o programador implementa essa tela e faz a conexão com o banco de dados.

---

## 10. Relação entre analistas e programadores

Analistas de sistemas e programadores trabalham próximos.

O analista entende o problema e define o que o sistema deve fazer.

O programador implementa a solução.

Exemplo:

```text
Usuário final solicita uma necessidade.
Analista transforma a necessidade em requisito.
Programador implementa o requisito no sistema.
Banco de dados armazena e recupera as informações.
```

Tanto analistas quanto programadores precisam conhecer os recursos oferecidos pelo SGBD, pois isso ajuda na criação de sistemas mais eficientes e seguros.

---

## 11. Comparação entre os principais atores

| Ator | Função principal |
|---|---|
| DBA | Administra o banco, controla acessos, segurança e desempenho |
| Analista de banco de dados/projetista | Planeja quais dados serão armazenados e como serão estruturados |
| Usuário final | Usa o banco para consultar, modificar dados e gerar relatórios |
| Analista de sistemas | Levanta requisitos e especifica as necessidades dos usuários |
| Programador de aplicações | Implementa sistemas e funcionalidades que acessam o banco |

---

## 12. Exemplo completo em um sistema escolar

Imagine um sistema de banco de dados para uma escola.

### DBA

Cuida do banco, cria usuários, define permissões, monitora desempenho e faz controle de segurança.

### Analista de banco de dados

Planeja a estrutura do banco, definindo entidades como:

- Aluno;
- Professor;
- Turma;
- Disciplina;
- Nota.

### Usuário final

Utiliza o sistema no dia a dia.

Exemplos:

- professor lança notas;
- secretaria cadastra alunos;
- aluno consulta boletim;
- direção gera relatórios.

### Analista de sistemas

Conversa com os usuários para entender o que o sistema precisa fazer.

Exemplo:

```text
O sistema precisa permitir matrícula de alunos em turmas.
```

### Programador

Cria as telas, funcionalidades e comandos que conectam o sistema ao banco.

Exemplo:

```text
Tela de cadastro de aluno.
Tela de lançamento de notas.
Relatório de alunos por turma.
```

---

## 13. O que memorizar

- O banco de dados possui diferentes tipos de usuários.
- Cada usuário tem uma função específica no ambiente de banco.
- O DBA administra o banco, controla acesso, segurança e desempenho.
- O analista de banco de dados/projetista define quais dados serão armazenados e como serão organizados.
- Os usuários finais utilizam o banco para consultar, modificar e gerar relatórios.
- O analista de sistemas identifica os requisitos dos usuários.
- O programador implementa os sistemas que acessam o banco.
- Analistas e programadores precisam conhecer os recursos do SGBD.

---

## 14. Resumo final

Os usuários de um banco de dados possuem papéis diferentes.

O DBA administra e protege o banco.  
Os analistas de banco de dados projetam sua estrutura.  
Os usuários finais utilizam os dados.  
Os analistas de sistemas levantam requisitos.  
Os programadores implementam as aplicações.

Essa divisão de papéis ajuda a manter o banco organizado, seguro e adequado às necessidades dos usuários.
