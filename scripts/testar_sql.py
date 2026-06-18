"""Testa todo o SQL do repositório usando SQLite (biblioteca padrão do Python).

O que ele faz:
1. Cria um banco de dados em memória a partir do script de exemplo
   (04-sql-basico/scripts/criacao-tabelas-exemplo.sql).
2. Executa todos os gabaritos de 05-exercicios/ contra esse banco.
3. Reporta, para cada arquivo, se as queries rodaram sem erro.

Assim garanto que os exemplos e respostas do repositório realmente funcionam.

Rodar (a partir da raiz do repositório):

    python3 scripts/testar_sql.py
"""

import sqlite3
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SCRIPT_CRIACAO = RAIZ / "04-sql-basico" / "scripts" / "criacao-tabelas-exemplo.sql"
PASTA_EXERCICIOS = RAIZ / "05-exercicios"


def criar_banco() -> sqlite3.Connection:
    """Cria um banco em memória já populado com os dados de exemplo."""
    conn = sqlite3.connect(":memory:")
    conn.execute("PRAGMA foreign_keys = ON;")
    conn.executescript(SCRIPT_CRIACAO.read_text(encoding="utf-8"))
    return conn


def dividir_em_comandos(sql: str) -> list[str]:
    """Quebra um arquivo .sql em comandos individuais, ignorando comentários."""
    linhas = []
    for linha in sql.splitlines():
        if linha.strip().startswith("--"):
            continue
        linhas.append(linha)
    texto = "\n".join(linhas)
    return [cmd.strip() for cmd in texto.split(";") if cmd.strip()]


def testar_arquivo(caminho: Path) -> list[str]:
    """Roda cada comando de um gabarito em um banco limpo. Devolve os erros."""
    erros: list[str] = []
    conn = criar_banco()
    try:
        for comando in dividir_em_comandos(caminho.read_text(encoding="utf-8")):
            try:
                conn.execute(comando)
            except sqlite3.Error as e:
                trecho = " ".join(comando.split())[:70]
                erros.append(f"{e}  -> em: {trecho}...")
    finally:
        conn.close()
    return erros


def coletar_arquivos() -> list[Path]:
    """Gabaritos dos exercícios + scripts de exemplo executáveis."""
    arquivos = list(PASTA_EXERCICIOS.rglob("gabarito-*.sql"))
    arquivos += (RAIZ / "06-sql-avancado" / "scripts").glob("*.sql")
    return sorted(arquivos)


def main() -> int:
    arquivos = coletar_arquivos()
    if not arquivos:
        print("Nenhum arquivo .sql encontrado para testar.")
        return 1

    total_erros = 0
    for arquivo in arquivos:
        rel = arquivo.relative_to(RAIZ)
        erros = testar_arquivo(arquivo)
        if erros:
            total_erros += len(erros)
            print(f"FALHOU  {rel}")
            for erro in erros:
                print(f"        - {erro}")
        else:
            print(f"OK      {rel}")

    print("-" * 60)
    if total_erros:
        print(f"{total_erros} erro(s) de SQL encontrado(s).")
        return 1
    print(f"Todos os {len(arquivos)} arquivos .sql rodaram sem erro. ✅")
    return 0


if __name__ == "__main__":
    sys.exit(main())
