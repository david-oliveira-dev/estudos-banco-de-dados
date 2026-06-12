# Níveis de Abstração em Banco de Dados

## 1. Ideia geral

Em um Sistema de Banco de Dados, os dados podem ser vistos em diferentes níveis de abstração.

Isso significa que nem todo usuário precisa enxergar o banco da mesma forma.

Um usuário comum vê apenas aquilo que precisa usar.  
O projetista do banco enxerga a estrutura lógica dos dados.  
O sistema, por dentro, lida com a forma física como esses dados são armazenados.

Essa separação ajuda a esconder detalhes técnicos de quem não precisa conhecê-los.

---

## 2. Arquitetura ANSI/SPARC

A arquitetura ANSI/SPARC organiza um Sistema de Banco de Dados em três níveis principais:

- nível externo;
- nível conceitual;
- nível interno.

Esses três níveis representam formas diferentes de descrever os mesmos dados.

A ideia é separar:

```text
O que o usuário vê.
Como o banco é organizado logicamente.
Como os dados são armazenados fisicamente.
```

---

## 3. Nível externo

O nível externo representa as diferentes visões que os usuários têm do banco de dados.

Cada grupo de usuários pode visualizar apenas a parte do banco que lhe interessa.

Exemplo em uma escola:

- o professor vê alunos, turmas e notas;
- o aluno vê suas próprias notas e frequência;
- a secretaria vê dados cadastrais;
- o financeiro vê dados de pagamento;
- a direção vê relatórios gerais.

Todos usam o mesmo banco, mas cada grupo enxerga uma visão diferente.

O nível externo está ligado à pergunta:

```text
O que o usuário precisa visualizar?
```

### Exemplo

Um professor não precisa acessar dados financeiros dos alunos.

Um aluno não precisa acessar dados administrativos do sistema.

O financeiro não precisa alterar notas.

Assim, o nível externo limita e organiza as informações de acordo com cada tipo de usuário.

---

## 4. Nível conceitual

O nível conceitual descreve a estrutura lógica de todo o banco de dados.

Ele mostra quais dados existem e como eles se relacionam, sem se preocupar com detalhes físicos de armazenamento.

Exemplo em uma escola:

```text
Aluno pertence a uma Turma.
Professor ministra Disciplina.
Aluno possui Nota.
Turma possui vários Alunos.
```

Nesse nível, pensamos nas entidades, atributos e relacionamentos.

Exemplo de entidades:

- Aluno;
- Professor;
- Turma;
- Disciplina;
- Nota.

O nível conceitual está ligado à pergunta:

```text
Como os dados estão organizados logicamente?
```

Ele é importante para projetistas, analistas e administradores do banco.

---

## 5. Nível interno

O nível interno descreve como os dados são armazenados fisicamente.

Ele trata de detalhes como:

- forma de armazenamento no disco;
- caminhos de acesso aos dados;
- índices;
- arquivos internos;
- estruturas físicas usadas pelo SGBD;
- organização física dos registros.

Esse nível é mais próximo do funcionamento interno do SGBD.

O nível interno está ligado à pergunta:

```text
Como os dados são armazenados fisicamente?
```

Usuários comuns normalmente não precisam conhecer esse nível.

---

## 6. Comparação entre os três níveis

| Nível | O que representa | Exemplo |
|---|---|---|
| Externo | Visão do usuário | Professor vê notas e turmas |
| Conceitual | Estrutura lógica do banco | Aluno, Turma, Professor, Nota |
| Interno | Armazenamento físico | Arquivos, índices, caminhos de acesso |

---

## 7. Exemplo completo

Imagine um sistema escolar.

### Nível externo

Cada usuário enxerga uma parte do sistema.

```text
Professor vê notas.
Aluno vê boletim.
Secretaria vê matrículas.
Financeiro vê pagamentos.
```

### Nível conceitual

O banco é organizado logicamente.

```text
Aluno
Turma
Professor
Disciplina
Nota
Matrícula
```

Relacionamentos:

```text
Aluno pertence a uma turma.
Professor ministra uma disciplina.
Aluno recebe notas.
```

### Nível interno

O SGBD decide como os dados serão armazenados.

```text
Arquivos internos.
Índices.
Organização física.
Caminhos de acesso.
```

---

## 8. Mapeamento entre níveis

Como os três níveis representam os mesmos dados de formas diferentes, é necessário fazer mapeamentos entre eles.

Mapeamento significa converter uma representação em outra.

Exemplo:

O usuário solicita:

```text
Mostrar as notas do aluno.
```

No nível externo, isso aparece como uma tela simples.

No nível conceitual, o sistema entende que precisa relacionar:

```text
Aluno
Disciplina
Nota
```

No nível interno, o SGBD localiza fisicamente esses dados no armazenamento.

Assim, a consulta percorre os níveis até chegar aos dados armazenados.

---

## 9. Importância dos níveis de abstração

Os níveis de abstração são importantes porque:

- escondem detalhes técnicos dos usuários;
- permitem diferentes visões para diferentes grupos;
- facilitam a organização lógica do banco;
- separam a visão do usuário da forma física de armazenamento;
- ajudam na manutenção do sistema;
- contribuem para a independência de dados.

---

## 10. Relação com independência de dados

A separação em níveis permite que mudanças em um nível não afetem necessariamente os outros.

Exemplo:

Se o SGBD mudar a forma física de armazenar os dados, o usuário final não precisa perceber essa mudança.

Isso é chamado de independência de dados.

O usuário continua acessando a mesma informação, mesmo que internamente o banco tenha mudado sua forma de armazenamento.

---

## 11. O que memorizar

- Um Sistema de Banco de Dados pode ser dividido em três níveis de abstração.
- O nível externo representa as visões dos usuários.
- O nível conceitual representa a estrutura lógica do banco.
- O nível interno representa a estrutura física de armazenamento.
- Os três níveis descrevem os mesmos dados de formas diferentes.
- É necessário mapear as informações entre os níveis.
- A separação dos níveis ajuda na independência de dados.

---

## 12. Resumo final

Os níveis de abstração organizam as diferentes formas de enxergar um banco de dados.

O nível externo mostra o que cada usuário vê.

O nível conceitual mostra como os dados estão organizados logicamente.

O nível interno mostra como os dados são armazenados fisicamente.

Essa separação torna o banco mais organizado, seguro, flexível e fácil de manter.
