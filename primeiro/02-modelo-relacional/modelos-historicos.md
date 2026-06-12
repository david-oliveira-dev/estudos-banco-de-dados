# Modelos Históricos: Hierárquico e em Rede

## 1. Contexto histórico

Antes do modelo relacional (proposto por Codd em 1970), outros modelos de banco de dados eram usados.

Os dois mais importantes foram:

- o **modelo hierárquico** (anos 1960);
- o **modelo em rede** (anos 1960–1970).

Estudar esses modelos ajuda a entender por que o modelo relacional se tornou dominante e quais problemas ele veio resolver.

---

## 2. Modelo hierárquico

O modelo hierárquico organiza os dados em forma de **árvore** — como um organograma ou uma estrutura de pastas.

Cada nó da árvore tem **um único pai** (exceto o nó raiz) e pode ter **vários filhos**.

### Estrutura

```
            ESCOLA
           /       \
        CURSO-A   CURSO-B
       /    \        |
  TURMA-1  TURMA-2  TURMA-3
   /  \
AL-1  AL-2
```

### Características

- Os dados são organizados em hierarquia pai-filho.
- Um filho tem exatamente um pai.
- Para acessar um dado, é necessário percorrer a árvore desde a raiz.

### Exemplo de acesso

Para consultar as notas do Aluno 1 (AL-1), seria necessário navegar:

```
ESCOLA → CURSO-A → TURMA-1 → AL-1
```

### Problema: relacionamentos N:M não são suportados

Imagine que um aluno pode estar em mais de uma turma. No modelo hierárquico, isso não é possível sem duplicar dados.

```
TURMA-1 → AL-1  (dados do aluno duplicados)
TURMA-2 → AL-1  (mesmos dados repetidos)
```

Isso gera **redundância e inconsistência**.

### Exemplo de SGBD hierárquico

- **IMS (Information Management System)** — criado pela IBM nos anos 1960 para o programa Apollo da NASA.

---

## 3. Modelo em rede

O modelo em rede foi proposto para resolver o problema do modelo hierárquico com relacionamentos N:M.

Em vez de uma árvore, os dados são organizados em um **grafo** — onde cada nó pode ter **vários pais e vários filhos**.

### Estrutura

```
    DISCIPLINA-A    DISCIPLINA-B
       /    \       /    \
   AL-1   AL-2  AL-2   AL-3
```

No modelo em rede, AL-2 pode pertencer a DISCIPLINA-A e DISCIPLINA-B ao mesmo tempo, sem duplicação.

### Características

- Suporta relacionamentos N:M nativamente.
- Os dados são acessados por ponteiros (caminhos definidos na estrutura).
- Para navegar nos dados, o programador precisa conhecer os caminhos definidos.

### Problema: dependência de caminhos físicos

Para consultar dados, o programador precisava escrever código que navegava pelos ponteiros físicos.

Se a estrutura do banco mudasse, todos os programas precisavam ser reescritos.

Exemplo de acesso em pseudocódigo:

```
FIND FIRST disciplina WHERE nome = 'Matemática'
FIND NEXT aluno VIA matrícula
WHILE aluno EXISTS
    PRINT aluno.nome
    FIND NEXT aluno VIA matrícula
END WHILE
```

Isso tornava os programas difíceis de manter e muito dependentes da estrutura física.

### Exemplo de SGBD em rede

- **IDMS (Integrated Database Management System)**
- **IDS (Integrated Data Store)** — criado por Charles Bachman na GE

---

## 4. Comparação entre os três modelos

| Aspecto | Hierárquico | Em rede | Relacional |
|---|---|---|---|
| Estrutura | Árvore | Grafo | Tabelas |
| Relacionamento N:M | Não suporta | Suporta | Suporta |
| Acesso aos dados | Navegação pela árvore | Navegação por ponteiros | Linguagem declarativa (SQL) |
| Dependência física | Alta | Alta | Baixa |
| Facilidade de uso | Difícil | Difícil | Fácil |
| Flexibilidade | Baixa | Média | Alta |
| Padrão hoje | Obsoleto | Obsoleto | Dominante |

---

## 5. Por que o modelo relacional venceu

O modelo relacional trouxe três vantagens decisivas:

1. **Linguagem declarativa (SQL):** o programador diz *o que* quer, não *como* navegar. O SGBD decide o caminho mais eficiente.

2. **Independência de dados:** a forma física de armazenamento é separada da forma lógica. Mudar a estrutura interna não quebra as aplicações.

3. **Relacionamentos flexíveis:** qualquer relação pode ser representada com tabelas e chaves estrangeiras, sem estrutura predefinida de navegação.

---

## 6. O que memorizar

- Modelo hierárquico = estrutura de árvore; não suporta N:M sem duplicar dados.
- Modelo em rede = estrutura de grafo; suporta N:M, mas o acesso é por ponteiros físicos.
- Modelo relacional = tabelas; SQL declarativo; independência de dados.
- Ambos os modelos históricos foram superados pelo relacional nos anos 1980–1990.

---

## 7. Resumo final

Os modelos hierárquico e em rede foram importantes marcos na história dos bancos de dados.

O modelo hierárquico organizava dados como árvores, mas tinha limitações sérias com relacionamentos complexos. O modelo em rede resolveu parte desses problemas, mas tornava o acesso dependente de caminhos físicos difíceis de manter.

O modelo relacional, com tabelas, SQL e independência de dados, resolveu essas limitações e se tornou o padrão que usamos até hoje.
