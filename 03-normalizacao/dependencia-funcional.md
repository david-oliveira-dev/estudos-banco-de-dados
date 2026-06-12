# Dependência Funcional

## 1. O que é dependência funcional?

Dependência funcional é o conceito central da normalização.

Dizemos que um atributo B **depende funcionalmente** de um atributo A quando, para cada valor de A, existe exatamente um valor de B.

Notação:

```
A → B
```

Lê-se: "A determina B" ou "B depende funcionalmente de A".

---

## 2. Exemplos

**Matrícula → Nome do aluno**

Dado um número de matrícula, conseguimos determinar exatamente qual aluno ele representa.

```
2024001 → Ana Lima
2024002 → Bruno Costa
```

**CPF → Data de nascimento**

Dado um CPF, existe exatamente uma data de nascimento associada.

**Cidade → Estado**

Dada uma cidade (dentro de um mesmo país), conseguimos determinar em qual estado ela está.

```
Goiânia → Goiás
Brasília → Distrito Federal
São Paulo → São Paulo
```

---

## 3. O que NÃO é dependência funcional

**Nome → Matrícula?**

Não. Podem existir dois alunos com o mesmo nome. O nome não determina a matrícula.

**Cidade → CEP?**

Não. Uma cidade tem vários CEPs. A cidade não determina o CEP.

---

## 4. Dependência funcional total

Uma dependência funcional é **total** quando o atributo depende da **chave inteira** e não de uma parte dela.

Exemplo — tabela com chave composta `(aluno_id, disciplina_id)`:

| aluno_id | disciplina_id | nota | nome_aluno |
|----------|--------------|------|------------|
| 1        | 10           | 8.5  | Ana Lima   |
| 1        | 20           | 7.0  | Ana Lima   |
| 2        | 10           | 9.0  | Bruno      |

- `nota` depende de `(aluno_id, disciplina_id)` — **dependência total**.
- `nome_aluno` depende só de `aluno_id` — **dependência parcial** (problema!).

---

## 5. Dependência funcional parcial

Uma dependência funcional é **parcial** quando um atributo não-chave depende de **apenas parte** da chave composta.

No exemplo acima:

```
aluno_id → nome_aluno   (parcial: só usa metade da chave)
```

Isso é um problema que a **2FN** resolve.

---

## 6. Dependência funcional transitiva

Uma dependência é **transitiva** quando um atributo não-chave depende de **outro atributo não-chave**.

Exemplo:

| matricula | nome  | curso        | coord_curso |
|-----------|-------|--------------|-------------|
| 2024001   | Ana   | Informática  | Prof. João  |
| 2024002   | Bruno | Informática  | Prof. João  |
| 2024003   | Carla | Mecânica     | Prof. Maria |

```
matricula → curso
curso → coord_curso
```

Portanto: `matricula → coord_curso` (transitivo via `curso`).

`coord_curso` depende de `matricula` indiretamente, passando por `curso`.

Isso é um problema que a **3FN** resolve.

---

## 7. Resumo dos tipos de dependência

| Tipo | Descrição | Problema resolvido por |
|---|---|---|
| Total | Atributo depende da chave inteira | — (correto) |
| Parcial | Atributo depende só de parte da chave | 2FN |
| Transitiva | Atributo depende de outro não-chave | 3FN |

---

## 8. O que memorizar

- `A → B` = "A determina B" = "B depende funcionalmente de A".
- Dado um valor de A, há exatamente um valor de B.
- Dependência parcial = depende só de parte da chave composta → resolvida na 2FN.
- Dependência transitiva = atributo não-chave depende de outro não-chave → resolvida na 3FN.

---

## 9. Resumo final

Dependência funcional descreve a relação de determinação entre atributos.

Identificar dependências totais, parciais e transitivas em uma tabela é o passo fundamental para aplicar as formas normais corretamente.
