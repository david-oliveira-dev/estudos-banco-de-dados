# Sistema Gerenciador de Banco de Dados - SGBD

## 1. O que é um SGBD?

SGBD significa **Sistema Gerenciador de Banco de Dados**.

Um SGBD é um conjunto de programas responsável por permitir que usuários e aplicações criem, organizem, acessem, modifiquem, protejam e recuperem dados armazenados em um banco de dados.

Em outras palavras, o SGBD é o software que fica entre o usuário e o banco de dados. Ele controla como os dados serão armazenados, consultados, atualizados, protegidos e recuperados.

Exemplos de SGBDs:

* PostgreSQL;
* MySQL;
* MariaDB;
* Microsoft SQL Server;
* Oracle.

Um banco de dados sem um SGBD seria apenas uma coleção de dados armazenados sem controle adequado. O SGBD oferece regras, segurança, organização e mecanismos para que esses dados possam ser usados de maneira eficiente.

---

## 2. Principais propriedades de um SGBD

Um Sistema Gerenciador de Banco de Dados possui várias propriedades importantes. Essas propriedades existem para garantir que os dados sejam armazenados de forma organizada, segura, consistente e acessível.

---

## 2.1 Controle de redundância

Redundância significa repetição desnecessária de dados.

Em sistemas tradicionais baseados em arquivos, cada usuário ou setor pode manter seus próprios arquivos com informações parecidas. Isso gera repetição de dados em vários locais.

Exemplo:

Uma escola pode ter:

* uma planilha da secretaria com dados dos alunos;
* uma planilha da coordenação com os mesmos alunos;
* uma planilha do financeiro com parte dos mesmos dados;
* arquivos dos professores com listas de alunos.

Se o telefone de um aluno mudar, será necessário alterar essa informação em vários arquivos diferentes.

O problema é que alguém pode esquecer de atualizar um dos arquivos. Assim, o mesmo aluno pode aparecer com telefones diferentes em locais diferentes.

Isso causa **inconsistência de dados**.

Exemplo de inconsistência:

```text
Secretaria: telefone do aluno = 9999-1111
Financeiro: telefone do aluno = 9888-2222
Coordenação: telefone do aluno = 9777-3333
```

Nesse caso, qual telefone está correto?

O SGBD ajuda a controlar esse problema porque centraliza os dados ou permite duplicações apenas de forma controlada. Assim, a mesma informação não precisa ficar repetida em vários lugares sem necessidade.

Portanto, o controle de redundância ajuda a:

* diminuir repetição de dados;
* economizar espaço de armazenamento;
* reduzir esforço de atualização;
* evitar inconsistências;
* melhorar a organização do banco.

---

## 2.2 Compartilhamento dos dados

Um SGBD permite que várias pessoas acessem o banco de dados ao mesmo tempo.

Esse é um ponto muito importante em sistemas reais.

Exemplo em uma escola:

* a secretaria cadastra alunos;
* os professores lançam notas;
* a coordenação consulta frequência;
* o financeiro acompanha pagamentos;
* a direção gera relatórios.

Todos esses usuários podem precisar acessar dados ao mesmo tempo.

Se não houver controle, duas pessoas poderiam tentar modificar a mesma informação simultaneamente e causar erro no banco.

Exemplo:

Dois usuários tentam atualizar a turma de um mesmo aluno ao mesmo tempo.

O SGBD precisa controlar esse acesso concorrente para garantir que o resultado final seja correto e consistente.

Esse controle é chamado de **controle de concorrência**.

O compartilhamento de dados permite que o banco seja usado por vários usuários, mas de forma organizada e segura.

---

## 2.3 Controle de acesso

Nem todos os usuários devem ter acesso a todas as informações do banco de dados.

Em uma organização, cada usuário possui uma função. Por isso, cada um deve ter permissões diferentes.

Exemplo em uma escola:

* o professor pode lançar e consultar notas;
* o aluno pode visualizar suas próprias notas;
* a secretaria pode alterar dados cadastrais;
* o financeiro pode consultar dados de pagamento;
* a direção pode acessar relatórios gerais;
* o DBA pode administrar usuários, permissões e segurança.

O SGBD permite criar contas de usuários com senhas e diferentes níveis de permissão.

Alguns usuários podem apenas consultar dados. Outros podem consultar e alterar. Outros podem inserir novos dados. Alguns podem excluir informações. Poucos usuários devem ter acesso administrativo.

Exemplo de permissões:

```text
Aluno: consultar as próprias notas.
Professor: consultar e lançar notas.
Secretaria: cadastrar e atualizar alunos.
DBA: criar usuários, definir permissões e administrar o banco.
```

Esse controle evita que pessoas sem autorização acessem dados confidenciais ou realizem alterações indevidas.

Portanto, o controle de acesso é fundamental para a segurança do banco de dados.

---

## 2.4 Possibilidade de múltiplas interfaces

Nem todos os usuários acessam o banco de dados da mesma forma.

Um usuário técnico pode usar comandos SQL diretamente.

Exemplo:

```sql
SELECT * FROM alunos;
```

Já um usuário comum pode acessar os mesmos dados por meio de uma interface gráfica, como uma tela com botões, menus e formulários.

Exemplo:

```text
[Buscar aluno]
[Cadastrar aluno]
[Editar matrícula]
[Gerar relatório]
```

Por trás dessa interface gráfica, o sistema envia comandos ao banco de dados.

O SGBD pode oferecer diferentes formas de acesso, como:

* interface por linha de comando;
* linguagem SQL;
* aplicações web;
* sistemas desktop;
* painéis administrativos;
* relatórios;
* interfaces gráficas;
* sistemas com menus.

Isso é importante porque usuários diferentes possuem níveis diferentes de conhecimento técnico.

Um programador pode trabalhar diretamente com SQL. Já um funcionário administrativo pode usar apenas uma tela visual.

Assim, o SGBD permite que o banco seja utilizado por diferentes perfis de usuários.

---

## 2.5 Representação de relacionamentos complexos entre dados

Os dados de um banco normalmente se relacionam entre si.

Exemplo em uma escola:

* um aluno pertence a uma turma;
* uma turma possui vários alunos;
* um professor ministra uma disciplina;
* uma disciplina pode ter várias turmas;
* um aluno possui várias notas;
* uma nota pertence a uma disciplina.

Essas relações entre os dados precisam ser representadas de forma organizada.

O SGBD permite armazenar e recuperar dados relacionados de maneira eficiente.

Exemplo:

Se temos uma tabela de alunos e uma tabela de turmas, é possível relacionar cada aluno com sua turma.

```text
Aluno -> Turma
Professor -> Disciplina
Aluno -> Nota
Disciplina -> Curso
```

Sem um SGBD, esses relacionamentos poderiam ficar espalhados em arquivos diferentes, dificultando consultas e atualizações.

Com um SGBD, essas relações podem ser modeladas e consultadas de forma estruturada.

---

## 2.6 Restrições de integridade

Integridade significa que os dados precisam fazer sentido e obedecer a regras.

O SGBD pode impor restrições para impedir que dados inválidos sejam armazenados.

Exemplo:

Ao cadastrar uma pessoa, podemos definir regras como:

* o nome deve ser texto;
* o nome deve ter menos de 50 caracteres;
* a idade deve ser número inteiro;
* a idade deve ser menor que 150;
* o CPF não pode se repetir;
* determinados campos não podem ficar vazios.

Exemplo de dados inválidos:

```text
Nome = 12345
Idade = "banana"
Idade = 999
CPF repetido para duas pessoas diferentes
```

O SGBD ajuda a evitar esse tipo de erro por meio de restrições.

Exemplo em SQL:

```sql
CREATE TABLE pessoa (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    idade INTEGER CHECK (idade >= 0 AND idade < 150)
);
```

Nesse exemplo:

* `nome VARCHAR(50)` indica que o nome será texto com até 50 caracteres;
* `NOT NULL` indica que o nome não pode ficar vazio;
* `idade INTEGER` indica que idade deve ser um número inteiro;
* `CHECK` define uma regra para a idade.

As restrições de integridade ajudam a manter os dados corretos, coerentes e confiáveis.

---

## 2.7 Backup e restauração de dados

Um SGBD deve permitir a criação de cópias de segurança dos dados.

Essas cópias são chamadas de **backups**.

O backup é importante porque sistemas podem falhar.

Exemplos de falhas:

* queda de energia;
* defeito no computador;
* erro no sistema;
* falha de hardware;
* falha de software;
* exclusão acidental de dados;
* interrupção durante uma atualização.

A restauração é o processo de recuperar os dados a partir de uma cópia de segurança ou de um estado anterior consistente.

Exemplo:

Imagine que um sistema está atualizando vários registros no banco de dados e ocorre uma falha no meio da operação.

O SGBD precisa garantir que o banco não fique em um estado quebrado ou incompleto.

Ele pode:

* restaurar o banco ao estado anterior;
* refazer a operação a partir do ponto interrompido;
* desfazer alterações incompletas.

Esse mecanismo é fundamental em sistemas bancários, escolares, comerciais e em qualquer sistema que dependa da confiabilidade dos dados.

---

# 3. Vantagens de um SGBD

A utilização correta de um SGBD traz várias vantagens para organizações, instituições e sistemas.

---

## 3.1 Potencial para garantir padrões

Um SGBD permite que o Administrador de Banco de Dados, chamado DBA, defina padrões para o banco.

Esses padrões podem envolver:

* nomes de tabelas;
* nomes de campos;
* tipos de dados;
* formatos de datas;
* terminologias;
* telas;
* relatórios;
* regras de cadastro;
* formas de acesso.

Exemplo:

Em vez de cada setor escrever o nome do aluno de uma maneira diferente, o banco pode definir um padrão único.

Sem padrão:

```text
David Alves
D. Alves
Alves, David
David A.
```

Com padrão, a organização define como os nomes devem ser cadastrados.

A padronização facilita a comunicação entre setores, melhora a qualidade dos dados e evita confusão.

---

## 3.2 Redução do tempo de desenvolvimento de aplicações

Criar um banco de dados pode exigir mais esforço no início. Porém, depois que a base está pronta, fica mais fácil desenvolver novas aplicações, consultas e relatórios.

Exemplo:

Uma escola já possui um banco com:

* alunos;
* professores;
* turmas;
* disciplinas;
* notas;
* frequência.

Com esses dados organizados, é mais fácil criar:

* boletim escolar;
* relatório de notas;
* sistema para pais;
* painel de frequência;
* dashboard de desempenho;
* consulta de alunos por turma.

O programador não precisa começar do zero a cada novo sistema. Ele pode reaproveitar a estrutura de dados existente.

Por isso, o uso de SGBD reduz o tempo de desenvolvimento de novas aplicações.

---

## 3.3 Independência de dados

Independência de dados significa que as aplicações não precisam depender diretamente da forma física como os dados estão armazenados.

O usuário ou o sistema faz uma consulta ao banco, e o SGBD cuida dos detalhes internos.

Exemplo:

```sql
SELECT nome FROM alunos;
```

Quem faz essa consulta não precisa saber exatamente:

* onde o dado está salvo no disco;
* como o arquivo interno está organizado;
* qual estrutura física o SGBD usa;
* como os índices estão armazenados.

O SGBD esconde essa complexidade.

Isso facilita o desenvolvimento e a manutenção das aplicações.

---

## 3.4 Flexibilidade

Com o tempo, os requisitos de um sistema podem mudar.

Exemplo:

Uma escola inicialmente guardava apenas:

* nome do aluno;
* matrícula;
* turma.

Depois passou a precisar guardar:

* e-mail do responsável;
* telefone do responsável;
* status da matrícula;
* data de nascimento.

Um SGBD moderno permite alterar a estrutura do banco de dados para incluir novas informações.

Exemplo em SQL:

```sql
ALTER TABLE alunos ADD COLUMN email_responsavel VARCHAR(100);
```

Essa flexibilidade permite que o banco evolua conforme novas necessidades aparecem.

---

## 3.5 Disponibilidade para atualizar informações

Quando um usuário atualiza uma informação no banco, essa alteração pode ficar disponível para os demais usuários.

Exemplo:

A secretaria atualiza o telefone de um aluno.

Depois disso:

* a coordenação vê o telefone atualizado;
* o professor vê o telefone atualizado;
* a direção vê o telefone atualizado;
* relatórios passam a usar o dado correto.

Isso evita que diferentes setores trabalhem com versões diferentes da mesma informação.

Esse recurso é essencial em sistemas que precisam de atualização imediata, como:

* bancos;
* sistemas de reservas de passagens;
* lojas virtuais;
* sistemas escolares;
* hospitais;
* sistemas financeiros.

---

## 3.6 Economia de escala

O SGBD permite consolidar dados e aplicações.

Em vez de cada setor manter seus próprios arquivos e sistemas separados, a organização pode usar uma estrutura centralizada.

Sem SGBD centralizado:

```text
Setor A mantém uma planilha.
Setor B mantém outro arquivo.
Setor C cria outro sistema.
Setor D compra outro software.
```

Com SGBD:

```text
Os dados ficam organizados em uma base comum.
Os sistemas acessam essa base de forma controlada.
A organização reduz duplicação e desperdício.
```

Isso pode diminuir custos com:

* armazenamento;
* processamento;
* manutenção;
* retrabalho;
* inconsistências;
* sistemas duplicados.

---

## 3.7 Alto custo inicial

Apesar das vantagens, a implantação de um banco de dados pode ter custo inicial elevado.

Esse custo pode envolver:

* planejamento;
* modelagem;
* instalação do SGBD;
* configuração;
* treinamento dos usuários;
* migração de dados antigos;
* criação de regras de segurança;
* backup;
* manutenção;
* contratação de profissionais especializados.

Por isso, o início pode ser mais trabalhoso. Porém, no médio e longo prazo, um banco bem estruturado tende a trazer mais organização, segurança e eficiência.

---

# 4. Linguagens usadas em um SGBD

Depois que o projeto do banco de dados é feito e o SGBD é escolhido, é necessário usar linguagens próprias para definir estruturas, manipular dados e controlar permissões.

As principais linguagens são:

* DDL;
* DML;
* DCL.

---

## 4.1 DDL - Linguagem de Definição de Dados

DDL significa **Data Definition Language**.

Em português, significa **Linguagem de Definição de Dados**.

Ela é usada para definir a estrutura do banco de dados.

Com DDL, podemos criar, alterar ou excluir estruturas como:

* tabelas;
* índices;
* esquemas;
* restrições;
* visões;
* estruturas internas.

Principais comandos DDL:

* `CREATE`;
* `ALTER`;
* `DROP`;
* `TRUNCATE`.

Exemplo de criação de tabela:

```sql
CREATE TABLE alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INTEGER
);
```

Nesse exemplo, a DDL está sendo usada para criar a tabela `alunos`.

A DDL não insere dados na tabela. Ela cria a estrutura onde os dados serão armazenados.

Resumo:

```text
DDL define a estrutura do banco.
```

---

## 4.2 DML - Linguagem de Manipulação de Dados

DML significa **Data Manipulation Language**.

Em português, significa **Linguagem de Manipulação de Dados**.

Ela é usada para manipular os dados armazenados nas tabelas.

Com DML, podemos:

* inserir dados;
* consultar dados;
* alterar dados;
* excluir dados.

Principais comandos DML:

* `SELECT`;
* `INSERT`;
* `UPDATE`;
* `DELETE`.

Exemplo de inserção:

```sql
INSERT INTO alunos (nome, idade)
VALUES ('Ana', 14);
```

Exemplo de consulta:

```sql
SELECT * FROM alunos;
```

Exemplo de atualização:

```sql
UPDATE alunos
SET idade = 15
WHERE nome = 'Ana';
```

Exemplo de exclusão:

```sql
DELETE FROM alunos
WHERE nome = 'Ana';
```

Resumo:

```text
DML manipula os dados armazenados.
```

---

## 4.3 Linguagem hospedeira e sublinguagem de dados

A DML pode ser usada isoladamente, diretamente no banco, como linguagem de consulta.

Exemplo:

```sql
SELECT * FROM alunos;
```

Mas ela também pode aparecer dentro de uma linguagem de programação, como Python, JavaScript, Java ou PHP.

Exemplo em JavaScript:

```javascript
const resultado = await db.query("SELECT * FROM alunos");
```

Nesse caso:

* JavaScript é a linguagem hospedeira;
* SQL é a sublinguagem de dados.

Isso acontece quando uma aplicação precisa conversar com o banco de dados.

---

## 4.4 DCL - Linguagem de Controle de Dados

DCL significa **Data Control Language**.

Em português, significa **Linguagem de Controle de Dados**.

Ela é usada para controlar acesso, permissões e segurança dentro do banco de dados.

Com DCL, é possível definir quais usuários podem acessar ou modificar determinados dados.

Principais comandos DCL:

* `GRANT`;
* `REVOKE`.

Exemplo de concessão de permissão:

```sql
GRANT SELECT ON alunos TO professor;
```

Esse comando permite que o usuário `professor` consulte a tabela `alunos`.

Exemplo de remoção de permissão:

```sql
REVOKE SELECT ON alunos FROM professor;
```

Esse comando remove a permissão de consulta.

Resumo:

```text
DCL controla permissões e acesso.
```

---

# 5. Comparação entre DDL, DML e DCL

| Linguagem | Nome completo              | Função principal           | Exemplos                               |
| --------- | -------------------------- | -------------------------- | -------------------------------------- |
| DDL       | Data Definition Language   | Define estruturas do banco | `CREATE`, `ALTER`, `DROP`              |
| DML       | Data Manipulation Language | Manipula dados             | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| DCL       | Data Control Language      | Controla permissões        | `GRANT`, `REVOKE`                      |

Frase para memorizar:

```text
DDL cria a estrutura.
DML mexe nos dados.
DCL controla o acesso.
```

---

# 6. Exemplos de SGBDs

Alguns exemplos de Sistemas Gerenciadores de Banco de Dados são:

* MySQL;
* PostgreSQL;
* Microsoft SQL Server;
* MariaDB;
* Oracle.

Neste estudo, o PostgreSQL foi escolhido como ferramenta principal de prática, porque é gratuito, robusto, muito usado no mercado e adequado para projetos de banco de dados, análise de dados e integração com aplicações.

---

# 7. Exemplo prático de entendimento

Imagine uma escola.

O banco de dados armazena:

* alunos;
* professores;
* turmas;
* disciplinas;
* notas.

O SGBD permite:

* cadastrar alunos;
* alterar dados de alunos;
* consultar notas;
* gerar relatórios;
* controlar quem pode acessar cada informação;
* garantir que os dados estejam corretos;
* fazer backup;
* restaurar dados em caso de falha.

Sem o SGBD, essas informações poderiam ficar espalhadas em planilhas, arquivos e documentos diferentes.

Com o SGBD, os dados ficam mais organizados, seguros e consistentes.

---

# 8. O que memorizar

* SGBD é o software que gerencia o banco de dados.
* O SGBD permite definir, construir, manipular e controlar bancos de dados.
* Redundância é repetição desnecessária de dados.
* Controle de redundância reduz inconsistências.
* Compartilhamento permite vários usuários usando os dados.
* Controle de acesso define quem pode ver ou modificar informações.
* Múltiplas interfaces permitem diferentes formas de acesso ao banco.
* Restrições de integridade garantem dados válidos.
* Backup e restauração protegem contra perdas.
* DDL define estruturas.
* DML manipula dados.
* DCL controla permissões.
* Exemplos de SGBDs: PostgreSQL, MySQL, MariaDB, SQL Server e Oracle.

---

# 9. Resumo final

Um Sistema Gerenciador de Banco de Dados é essencial para organizar, proteger, recuperar e manipular dados.

Ele resolve problemas comuns de sistemas baseados apenas em arquivos, como redundância, inconsistência, dificuldade de compartilhamento, falta de segurança e dificuldade de recuperação.

Além disso, fornece linguagens para definir estruturas, manipular dados e controlar acessos.

Por isso, o SGBD é uma das principais ferramentas para qualquer sistema que dependa de armazenamento e recuperação eficiente de informações.
