# Azure Policy

## O que é

Azure Policy é um serviço de governança usado para criar, atribuir e avaliar regras sobre recursos Azure.

Uma política pode verificar se determinada configuração atende a um requisito organizacional.

## Elementos

**Policy Definition** — descreve a regra.

**Assignment** — aplica a definição a um escopo.

**Initiative** — agrupa várias definições relacionadas.

**Compliance** — apresenta o resultado da avaliação.

## Exemplo

Uma organização pode exigir que recursos possuam a tag `Environment`.

Em modo `Audit`, a política identifica recursos que não seguem o padrão sem necessariamente impedir sua criação.

Em um ambiente controlado, uma política `Deny` pode impedir configurações proibidas.

## Recomendações

Teste primeiro em escopo controlado, avalie impactos e documente exceções antes de ampliar a aplicação.
