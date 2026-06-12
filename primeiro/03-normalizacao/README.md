# Módulo 03 — Normalização

Normalização é o processo de organizar as tabelas de um banco de dados para eliminar redundâncias e garantir consistência.

## Conteúdo

| Arquivo | Tema |
|---|---|
| [introducao.md](introducao.md) | O que é normalização e por que ela existe |
| [dependencia-funcional.md](dependencia-funcional.md) | Conceito fundamental para entender as formas normais |
| [1fn.md](1fn.md) | Primeira Forma Normal — eliminar grupos repetitivos |
| [2fn.md](2fn.md) | Segunda Forma Normal — eliminar dependências parciais |
| [3fn.md](3fn.md) | Terceira Forma Normal — eliminar dependências transitivas |
| [exemplos-praticos.md](exemplos-praticos.md) | Normalização completa: nota fiscal e formulário |

## Sequência recomendada

1. introducao.md
2. dependencia-funcional.md
3. 1fn.md
4. 2fn.md
5. 3fn.md
6. exemplos-praticos.md

## Visão geral do processo

```
Tabela sem normalizar
        ↓
   1FN — elimina grupos repetitivos e valores multivalorados
        ↓
   2FN — elimina dependências parciais da chave
        ↓
   3FN — elimina dependências transitivas
        ↓
   Tabela bem estruturada, sem redundância
```
