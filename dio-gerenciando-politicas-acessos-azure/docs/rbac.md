# Azure RBAC

Azure Role-Based Access Control (RBAC) controla o acesso aos recursos Azure com base em funções.

## Modelo

```text
Identidade
   ↓
Role Assignment
   ↓
Role Definition
   ↓
Scope
```

## Escopos

As permissões podem ser aplicadas em diferentes níveis:

- Management Group
- Subscription
- Resource Group
- Resource

Quanto mais amplo o escopo, maior o impacto potencial da atribuição.

## Menor privilégio

Conceda somente as permissões necessárias para executar uma tarefa.

Exemplos de papéis conhecidos incluem Reader, Contributor e Owner. A escolha deve considerar a responsabilidade real da identidade.

## Policy x RBAC

RBAC responde principalmente:

> "Quem pode fazer o quê?"

Azure Policy responde principalmente:

> "Quais configurações são permitidas ou desejadas?"

Os dois mecanismos são complementares.
