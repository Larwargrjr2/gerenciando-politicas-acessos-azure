# 🔐 Gerenciando Políticas em Acessos Azure

<p align="center">
  <img src="images/arquitetura-governanca.svg" alt="Arquitetura de Governança e Políticas no Azure">
</p>

<p align="center">
  <strong>Laboratório prático de Governança, Conformidade, Azure Policy e Controle de Acessos</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Microsoft%20Azure-AZ--900-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white" alt="Microsoft Azure">
  <img src="https://img.shields.io/badge/Azure%20Policy-Governance-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white" alt="Azure Policy">
  <img src="https://img.shields.io/badge/Azure%20RBAC-Access%20Control-5C2D91?style=for-the-badge&logo=microsoftazure&logoColor=white" alt="Azure RBAC">
  <img src="https://img.shields.io/badge/Azure%20CLI-Automation-0078D4?style=for-the-badge&logo=azure&logoColor=white" alt="Azure CLI">
</p>

---

## 📌 Sobre o Projeto

Este projeto foi desenvolvido como parte da formação **Microsoft Azure – AZ-900 Certification**, com o objetivo de consolidar conhecimentos relacionados a **governança, conformidade, políticas e controle de acessos em ambientes Microsoft Azure**.

A proposta é transformar os conceitos apresentados no laboratório da DIO em uma estrutura prática e documentada, demonstrando como diferentes mecanismos do Azure podem trabalhar em conjunto para manter ambientes organizados, seguros e alinhados às regras definidas por uma organização.

O projeto utiliza como principais conceitos:

* **Azure Policy**;
* **Azure RBAC**;
* **Microsoft Entra ID**;
* **Compliance**;
* **Policy Assignment**;
* **Policy Definition**;
* **Escopos de gerenciamento**;
* **Tags**;
* **Princípio do menor privilégio**;
* **Governança e conformidade**;
* **Azure CLI**;
* **Automação de tarefas administrativas**.

---

## 🎯 Objetivos

### Objetivo geral

Compreender e demonstrar como implementar mecanismos de governança e controle no Azure utilizando políticas e permissões baseadas em funções.

### Objetivos específicos

* Entender o funcionamento do **Azure Policy**;
* Diferenciar **Azure Policy** de **Azure RBAC**;
* Conhecer os principais escopos de gerenciamento;
* Criar e atribuir políticas;
* Avaliar conformidade dos recursos;
* Utilizar políticas para padronização de ambientes;
* Aplicar o princípio do menor privilégio;
* Utilizar tags como mecanismo de organização;
* Automatizar operações com Azure CLI;
* Documentar evidências e resultados;
* Aplicar boas práticas de governança e segurança.

---

# ☁️ Conceitos Fundamentais

## Azure Policy

O **Azure Policy** é um serviço de governança que permite definir regras para avaliar e controlar configurações de recursos Azure.

Em vez de depender exclusivamente de verificações manuais, uma organização pode estabelecer políticas que avaliem automaticamente se os recursos estão de acordo com determinados padrões.

### Exemplos de utilização

Uma política pode ser utilizada para:

* exigir determinadas tags;
* restringir determinadas configurações;
* auditar recursos;
* impedir determinadas implantações;
* avaliar conformidade;
* padronizar configurações;
* apoiar requisitos de governança.

---

## Policy Definition

A **Policy Definition** representa a regra que será utilizada durante a avaliação.

Ela define:

* qual recurso será avaliado;
* quais condições serão verificadas;
* qual comportamento deverá ocorrer quando uma condição for atendida.

Exemplo conceitual:

```text
Se um recurso não possuir a tag "Environment"
        ↓
considerar o recurso fora do padrão
        ↓
registrar ou bloquear conforme o efeito configurado
```

---

## Policy Assignment

A **Policy Assignment** é responsável por aplicar uma política a determinado escopo.

Uma definição de política pode existir sem estar aplicada a um ambiente específico.

O assignment determina:

```text
Policy Definition
       ↓
Policy Assignment
       ↓
Scope
       ↓
Recursos avaliados
```

---

# 🛡️ Efeitos das Políticas

O Azure Policy possui diferentes efeitos que determinam o comportamento da avaliação.

## Audit

Utilizado principalmente para **identificar configurações não conformes** sem necessariamente bloquear a implantação.

É uma boa opção para iniciar um processo de governança porque permite conhecer o impacto da regra antes de adotar controles mais restritivos.

```text
Recurso
   ↓
Avaliação
   ↓
Não conforme
   ↓
Registro de Compliance
```

---

## Deny

Impede determinadas operações quando elas violam a política.

```text
Solicitação
    ↓
Azure Policy
    ↓
Viola regra?
   ↙     ↘
 SIM      NÃO
  ↓        ↓
DENY     Permite
```

O uso de `Deny` deve ser planejado cuidadosamente para evitar impactos inesperados em aplicações ou equipes.

---

## Modify

Pode alterar determinadas propriedades de um recurso durante a avaliação, quando a definição e as permissões necessárias permitem essa operação.

Um caso comum é auxiliar na padronização de propriedades ou tags.

---

## DeployIfNotExists

Pode executar uma implantação complementar quando determinada condição é identificada e os requisitos da política são atendidos.

É útil para cenários de conformidade mais avançados.

---

# 🔑 Azure RBAC

O **Azure Role-Based Access Control (RBAC)** é utilizado para controlar **quem pode realizar determinadas ações sobre os recursos Azure**.

Uma forma simples de entender RBAC é:

> **Quem pode fazer o quê e em qual escopo?**

O modelo envolve:

```text
Identidade
    ↓
Role Assignment
    ↓
Role Definition
    ↓
Scope
```

### Exemplos de funções

| Função      | Conceito                                                    |
| ----------- | ----------------------------------------------------------- |
| Reader      | Permite visualizar recursos                                 |
| Contributor | Permite gerenciar recursos sem administrar acessos          |
| Owner       | Possui permissões amplas, incluindo gerenciamento de acesso |

A função adequada deve sempre ser escolhida de acordo com a necessidade real.

---

# 🔄 Azure Policy x Azure RBAC

Essas duas tecnologias são complementares.

| Tecnologia         | Pergunta principal                     |
| ------------------ | -------------------------------------- |
| Microsoft Entra ID | Quem é a identidade?                   |
| Azure RBAC         | O que essa identidade pode fazer?      |
| Azure Policy       | Quais regras os recursos devem seguir? |
| Compliance         | O ambiente está seguindo essas regras? |

### Exemplo

Imagine uma empresa que possui uma equipe de desenvolvimento.

O RBAC pode determinar:

```text
Desenvolvedor
     ↓
Contributor
     ↓
Resource Group
```

Enquanto o Azure Policy pode determinar:

```text
Todo recurso
     ↓
Deve possuir Environment
     ↓
Audit
```

Assim, uma tecnologia controla **permissões**, enquanto a outra controla **governança e conformidade**.

---

# 🏢 Hierarquia de Gerenciamento

O Azure permite organizar recursos em diferentes níveis de escopo.

```text
Management Group
        │
        ▼
Subscription
        │
        ▼
Resource Group
        │
        ▼
Resource
```

## Management Group

Pode organizar múltiplas assinaturas e facilitar a aplicação de políticas e governança em escala.

## Subscription

Representa uma assinatura Azure, normalmente associada a uma estrutura de cobrança e gerenciamento.

## Resource Group

Agrupa recursos relacionados que compartilham um ciclo de vida semelhante.

## Resource

É o recurso individual, como:

* Virtual Machine;
* Storage Account;
* Virtual Network;
* Azure SQL;
* Key Vault;
* App Service.

---

# 🏷️ Estratégia de Tags

Tags são importantes para organização, governança e análise de custos.

Neste laboratório, uma estratégia possível é:

| Tag           | Exemplo     |
| ------------- | ----------- |
| `Environment` | `lab`       |
| `Project`     | `az900`     |
| `Owner`       | `student`   |
| `CostCenter`  | `training`  |
| `ManagedBy`   | `azure-cli` |

### Benefícios

As tags ajudam a:

* identificar recursos;
* organizar ambientes;
* apoiar análise de custos;
* facilitar inventário;
* criar padrões organizacionais;
* melhorar a governança.

> **Importante:** tags não substituem RBAC, autenticação ou controles de segurança.

---

# 🧪 Laboratório Prático

## Pré-requisitos

Para executar os scripts deste projeto:

* uma assinatura Microsoft Azure;
* Azure CLI instalada;
* usuário autenticado;
* permissões suficientes no escopo utilizado;
* terminal Bash ou ambiente compatível.

Autenticação:

```bash
az login
```

Verificação:

```bash
az account show --output table
```

---

# 🚀 Executando o Laboratório

## 1. Listar políticas disponíveis

```bash
./scripts/listar-politicas.sh
```

O script apresenta informações sobre definições de políticas disponíveis no ambiente.

---

## 2. Criar o laboratório

```bash
./scripts/deploy-policy-lab.sh
```

Por padrão, o laboratório utiliza:

```text
Resource Group: rg-policy-az900
Location: eastus
Policy: require-environment-tag
Tag: Environment
```

As variáveis podem ser alteradas:

```bash
RG=rg-meu-lab LOCATION=eastus ./scripts/deploy-policy-lab.sh
```

---

## 3. Verificar conformidade

Depois da implantação:

```bash
./scripts/check-compliance.sh
```

Também é possível acompanhar o resultado pelo portal Azure:

```text
Azure Portal
     ↓
Policy
     ↓
Compliance
```

A avaliação das políticas pode levar algum tempo após uma atribuição ou alteração.

---

# 🔬 Cenário de Teste

## Cenário 1 — Recurso sem tag

Imagine um recurso:

```text
Storage Account
Environment: ❌ ausente
```

A política deverá identificar a configuração de acordo com o efeito definido.

---

## Cenário 2 — Recurso com tag

Agora:

```text
Storage Account
Environment: lab
```

Após a avaliação da política, o estado de conformidade pode ser comparado com o cenário anterior.

Esse processo permite visualizar na prática o papel do Azure Policy na governança.

---

# 📊 Fluxo de Conformidade

```text
                    ┌──────────────────────┐
                    │   Policy Definition  │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │   Policy Assignment  │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │      Resource        │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │     Evaluation       │
                    └──────────┬───────────┘
                               │
                       ┌───────┴───────┐
                       ▼               ▼
                  Conforme        Não conforme
                       │               │
                       ▼               ▼
                   Compliance       Correção
```

---

# 🏗️ Arquitetura

A arquitetura conceitual do projeto combina identidade, controle de acesso e governança:

```text
                 ┌─────────────────────┐
                 │  Microsoft Entra ID │
                 │    Identidades      │
                 └──────────┬──────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │     Azure RBAC      │
                 │ Permissões / Roles  │
                 └──────────┬──────────┘
                            │
             ┌──────────────┴──────────────┐
             │                             │
             ▼                             ▼
    ┌─────────────────┐          ┌─────────────────┐
    │   Azure Policy  │          │  Azure Resources│
    │ Regras / Audit  │─────────▶│ VM / Storage /  │
    │ Compliance      │          │ SQL / Network   │
    └─────────────────┘          └─────────────────┘
             │
             ▼
    ┌─────────────────┐
    │    Compliance   │
    │  Governança     │
    └─────────────────┘
```

---

# 📁 Estrutura do Projeto

```text
dio-gerenciando-politicas-acessos-azure/
│
├── README.md
├── .gitignore
│
├── docs/
│   ├── azure-policy.md
│   ├── rbac.md
│   ├── governanca.md
│   └── checklist.md
│
├── images/
│   └── arquitetura-governanca.svg
│
└── scripts/
    ├── listar-politicas.sh
    ├── deploy-policy-lab.sh
    ├── check-compliance.sh
    └── cleanup.sh
```

---

# ⚙️ Automação

O projeto utiliza **Azure CLI** para reduzir operações manuais.

### Inventário

```bash
./scripts/listar-politicas.sh
```

### Implantação

```bash
./scripts/deploy-policy-lab.sh
```

### Validação

```bash
./scripts/check-compliance.sh
```

### Limpeza

```bash
./scripts/cleanup.sh
```

A automação facilita a repetibilidade do laboratório e reduz erros durante a configuração.

---

# 🧹 Limpeza dos Recursos

Laboratórios Azure devem possuir uma estratégia de limpeza para evitar recursos esquecidos.

Execute:

```bash
./scripts/cleanup.sh
```

O script exige uma confirmação explícita antes de iniciar a exclusão.

> **Atenção:** confirme cuidadosamente o Resource Group antes de executar qualquer comando de exclusão.

---

# 🛡️ Boas Práticas de Governança

### 1. Começar com Audit

Antes de bloquear operações, avalie o impacto da política.

### 2. Utilizar menor privilégio

Conceda somente as permissões necessárias.

### 3. Aplicar políticas no escopo correto

Evite aplicar uma política global quando o requisito é específico de um Resource Group.

### 4. Documentar exceções

Exceções devem possuir justificativa e escopo controlado.

### 5. Monitorar Compliance

A criação da política não encerra o processo. É necessário acompanhar continuamente os resultados.

### 6. Padronizar tags

Estabeleça uma convenção consistente para facilitar governança e custos.

### 7. Testar antes de utilizar Deny

Uma política muito restritiva pode impedir implantações legítimas.

### 8. Automatizar

Utilize Azure CLI, infraestrutura como código e processos automatizados quando apropriado.

---

# 📸 Evidências do Laboratório

Após executar o projeto em uma assinatura Azure, recomenda-se adicionar evidências reais:

* [ ] Login e assinatura utilizada;
* [ ] Resource Group;
* [ ] Policy Definition;
* [ ] Policy Assignment;
* [ ] Escopo da política;
* [ ] Estado de Compliance;
* [ ] Recurso avaliado;
* [ ] Teste sem tag;
* [ ] Teste com tag;
* [ ] Configuração de RBAC;
* [ ] Saída dos scripts;
* [ ] Limpeza dos recursos.

### ⚠️ Segurança

Antes de publicar screenshots ou logs:

* remova tokens;
* remova chaves;
* remova senhas;
* remova secrets;
* oculte informações confidenciais;
* não publique credenciais Azure.

---

# 📚 O Que Foi Aprendido

Durante o desenvolvimento deste projeto, os principais aprendizados foram:

### Governança

A governança fornece mecanismos para estabelecer padrões e controlar a evolução do ambiente cloud.

### Azure Policy

Permite automatizar avaliações de conformidade e aplicar regras organizacionais aos recursos.

### RBAC

Permite controlar permissões de maneira granular através de funções e escopos.

### Menor privilégio

Reduz a superfície de risco ao evitar permissões maiores que as necessárias.

### Compliance

Permite acompanhar se os recursos estão seguindo as regras estabelecidas.

### Automação

Azure CLI torna o laboratório reproduzível e facilita operações administrativas.

---

# 💼 Aplicação em Cenários Reais

Os conceitos deste laboratório podem ser aplicados em organizações que precisam:

* padronizar recursos Azure;
* controlar configurações;
* atender requisitos de conformidade;
* limitar permissões;
* controlar ambientes de desenvolvimento;
* melhorar governança;
* reduzir configurações inconsistentes;
* automatizar processos;
* estabelecer políticas corporativas.

Um ambiente corporativo pode evoluir de:

```text
Configuração manual
        ↓
Políticas de auditoria
        ↓
Monitoramento de Compliance
        ↓
Correções automatizadas
        ↓
Controles preventivos
        ↓
Governança em escala
```

---

# 🧠 Conclusão

O laboratório demonstra que segurança e governança no Azure não dependem de uma única ferramenta.

Uma arquitetura bem estruturada combina:

```text
Microsoft Entra ID
        +
Azure RBAC
        +
Azure Policy
        +
Tags
        +
Compliance
        +
Monitoramento
        +
Automação
```

Enquanto o **Microsoft Entra ID** trabalha com identidades, o **Azure RBAC** controla permissões e o **Azure Policy** estabelece e avalia regras de governança.

A combinação desses mecanismos permite construir ambientes Azure mais **organizados, previsíveis, seguros e alinhados às necessidades da organização**.

---

# 📚 Documentação Complementar

* [Azure Policy](docs/azure-policy.md)
* [Azure RBAC](docs/rbac.md)
* [Governança](docs/governanca.md)
* [Checklist do laboratório](docs/checklist.md)

---

# 🔗 Referências

* Microsoft Learn — Azure Policy
* Microsoft Learn — Azure Role-Based Access Control
* Microsoft Learn — Azure Governance
* Microsoft Learn — Microsoft Entra ID
* Microsoft Learn — Azure CLI

---

# 👨‍💻 Projeto

**Desafio:** Gerenciando Políticas em Acessos Azure
**Formação:** Microsoft Azure – AZ-900 Certification
**Plataforma:** DIO
**Tecnologias:** Microsoft Azure • Azure Policy • Azure RBAC • Microsoft Entra ID • Azure CLI • Bash

---

<p align="center">
  Desenvolvido como projeto prático de estudos em Microsoft Azure ☁️
