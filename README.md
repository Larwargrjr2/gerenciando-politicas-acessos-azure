# Gerenciando Políticas em Acessos Azure

Projeto prático da formação **Microsoft Azure – AZ-900 Certification**, com foco em governança, conformidade, controle de acesso e aplicação de políticas no Azure.

## 🎯 Objetivo

Demonstrar como utilizar **Azure Policy**, **Azure RBAC**, escopos de gerenciamento e mecanismos de conformidade para estabelecer padrões de governança e controlar configurações de recursos.

> **Nota:** este repositório fornece um laboratório executável e documentação. Ele não afirma que recursos ou políticas foram efetivamente executados na assinatura do autor. As evidências reais devem ser adicionadas após a execução.

## 🧠 Conceitos abordados

- Azure Policy
- Policy Definition
- Policy Assignment
- Compliance
- Azure RBAC
- Princípio do menor privilégio
- Escopos de gerenciamento
- Resource Groups
- Tags e governança
- Auditoria de configurações
- Deny, Audit e Modify
- Azure CLI
- Boas práticas de segurança e conformidade

## 🏗️ Arquitetura conceitual

```text
Management Group
       │
       ├── Subscription
       │      │
       │      ├── Resource Group
       │      │       │
       │      │       └── Recursos Azure
       │      │
       │      └── RBAC
       │
       └── Azure Policy
              │
              ├── Assignment
              ├── Evaluation
              └── Compliance
```

![Arquitetura de Governança](images/arquitetura-governanca.svg)

## 🔐 Azure Policy x RBAC

| Tecnologia | Finalidade |
|---|---|
| Azure Policy | Define e avalia regras de conformidade para recursos |
| Azure RBAC | Controla quem pode executar quais ações |
| Microsoft Entra ID | Gerencia identidades e autenticação |
| Tags | Organizam recursos e apoiam governança |
| Compliance | Mostra aderência às políticas atribuídas |

**Policy não substitui RBAC.** Policy estabelece requisitos e regras para recursos; RBAC controla permissões de usuários, grupos, identidades e serviços.

## 📋 Modos de efeito

Exemplos comuns:

- **Audit:** registra configurações não conformes.
- **Deny:** impede operações que violem a política.
- **Modify:** pode alterar determinadas propriedades durante a avaliação, quando suportado e corretamente configurado.
- **DeployIfNotExists:** pode implantar recursos/configurações auxiliares quando condições específicas forem atendidas.

Para um primeiro laboratório, recomenda-se começar com **Audit**, avaliar o resultado e só depois considerar controles mais restritivos.

## 🚀 Laboratório com Azure CLI

### Pré-requisitos

- Assinatura Azure;
- Azure CLI instalado;
- `az login` realizado;
- Permissões adequadas no escopo utilizado.

### 1. Login

```bash
az login
az account show --output table
```

### 2. Listar políticas disponíveis

```bash
./scripts/listar-politicas.sh
```

### 3. Criar uma iniciativa de laboratório

O script abaixo cria um Resource Group de laboratório e aplica uma política de auditoria relacionada a tags.

```bash
./scripts/deploy-policy-lab.sh
```

Por padrão, o script usa:

```text
Resource Group: rg-policy-az900
Tag obrigatória: Environment
Valor sugerido: lab
```

Você pode alterar as variáveis antes da execução.

### 4. Verificar conformidade

```bash
./scripts/check-compliance.sh
```

Também é possível consultar o portal em:

**Azure Portal → Policy → Compliance**

### 5. Limpar o laboratório

```bash
./scripts/cleanup.sh
```

O script solicita confirmação antes de excluir o Resource Group criado pelo laboratório.

## 🧪 Exemplos de testes

### Teste 1 — recurso sem a tag

Crie ou utilize um recurso sem a tag `Environment`.

A política de auditoria deverá identificar a configuração como potencialmente não conforme após a avaliação da Policy.

### Teste 2 — recurso com a tag

Aplique:

```text
Environment = lab
```

Depois aguarde a avaliação da Azure Policy e compare o estado de conformidade.

> A avaliação de políticas pode não ser instantânea. Use uma reavaliação quando necessário.

## 🏷️ Estratégia de governança

Uma convenção simples para laboratório:

| Tag | Exemplo |
|---|---|
| Environment | lab |
| Project | az900 |
| Owner | student |
| CostCenter | training |
| ManagedBy | azure-cli |

Tags são úteis para organização, custos e governança, mas não devem ser tratadas como mecanismo de segurança ou controle de acesso.

## 🔎 Checklist de evidências

Após executar o laboratório, adicione evidências reais:

- [ ] Assinatura selecionada;
- [ ] Resource Group criado;
- [ ] Policy Definition identificada;
- [ ] Policy Assignment criada;
- [ ] Estado de Compliance consultado;
- [ ] Recurso avaliado;
- [ ] Teste de conformidade realizado;
- [ ] RBAC revisado;
- [ ] Tags verificadas;
- [ ] Recursos de laboratório removidos.

**Nunca publique tokens, chaves, senhas ou informações confidenciais.**

## 🛡️ Boas práticas

1. Comece com políticas em modo de auditoria.
2. Valide o impacto antes de utilizar `Deny`.
3. Aplique políticas no menor escopo necessário.
4. Utilize RBAC com menor privilégio.
5. Evite atribuições excessivamente amplas sem necessidade.
6. Documente exceções.
7. Revise políticas e assignments periodicamente.
8. Monitore a conformidade.
9. Use iniciativas para organizar políticas relacionadas.
10. Automatize verificações quando possível.

## 📚 Documentação

- [Governança](docs/governanca.md)
- [Azure Policy](docs/azure-policy.md)
- [RBAC](docs/rbac.md)
- [Checklist](docs/checklist.md)

## 👨‍💻 Sobre o projeto

**Desafio:** Gerenciando Políticas em Acessos Azure  
**Formação:** Microsoft Azure – AZ-900 Certification  
**Foco:** Governança, conformidade, Azure Policy e controle de acesso.
