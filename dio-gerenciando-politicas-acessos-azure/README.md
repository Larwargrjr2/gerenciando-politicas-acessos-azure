# ☁️ Gerenciando Políticas em Acessos Azure

<div align="center">

![Microsoft Azure](https://img.shields.io/badge/Microsoft%20Azure-0089D6?style=for-the-badge\&logo=microsoftazure\&logoColor=white)
![Azure Policy](https://img.shields.io/badge/Azure%20Policy-Governance-0078D4?style=for-the-badge\&logo=microsoftazure\&logoColor=white)
![Azure RBAC](https://img.shields.io/badge/Azure%20RBAC-Identity%20%26%20Access-5C2D91?style=for-the-badge\&logo=microsoftazure\&logoColor=white)
![Azure CLI](https://img.shields.io/badge/Azure%20CLI-Automation-0078D4?style=for-the-badge\&logo=azurecli\&logoColor=white)
![AZ-900](https://img.shields.io/badge/AZ--900-Certification%20Track-00A4EF?style=for-the-badge)

**Governança • Conformidade • Identidade • Controle de Acesso • Automação**

Projeto prático desenvolvido durante a formação **Microsoft Azure – AZ-900 Certification**, explorando mecanismos de governança, políticas, conformidade e controle de acessos em ambientes Azure.

</div>

---

## 📌 Sobre o Projeto

O projeto **Gerenciando Políticas em Acessos Azure** foi desenvolvido com o objetivo de transformar conceitos de governança e segurança estudados no AZ-900 em um laboratório prático e documentado.

A proposta combina diferentes mecanismos do ecossistema Azure para demonstrar como uma organização pode estabelecer padrões, controlar permissões e acompanhar a conformidade de seus recursos.

### Principais tecnologias e conceitos

* **Azure Policy**
* **Azure RBAC**
* **Microsoft Entra ID**
* **Policy Definition**
* **Policy Assignment**
* **Compliance**
* **Management Groups**
* **Subscriptions**
* **Resource Groups**
* **Tags**
* **Azure CLI**
* **Princípio do menor privilégio**
* **Governança e conformidade**

---

# 🎯 Objetivos

Este laboratório foi estruturado para demonstrar a aplicação prática dos seguintes objetivos:

### 01 · Governança

Estabelecer regras capazes de orientar a configuração dos recursos Azure de acordo com padrões definidos.

### 02 · Conformidade

Avaliar recursos e identificar configurações que estejam fora dos requisitos estabelecidos.

### 03 · Controle de acesso

Compreender como o **Azure RBAC** determina quais identidades podem executar determinadas ações em determinados escopos.

### 04 · Segurança

Aplicar conceitos como **menor privilégio**, separação de responsabilidades e controle de permissões.

### 05 · Automação

Utilizar **Azure CLI** para executar tarefas do laboratório de maneira reproduzível.

---

# 🏛️ Arquitetura da Solução

```text
                         ┌───────────────────────────────┐
                         │      Microsoft Entra ID       │
                         │       Identidades             │
                         │       Autenticação            │
                         └───────────────┬───────────────┘
                                         │
                                         ▼
                         ┌───────────────────────────────┐
                         │          Azure RBAC            │
                         │                                │
                         │       Quem pode fazer o quê?   │
                         └───────────────┬───────────────┘
                                         │
                                         ▼
┌───────────────────────────────────────────────────────────────────────┐
│                       Azure Management Scope                          │
│                                                                       │
│  Management Group                                                     │
│       │                                                               │
│       └── Subscription                                                │
│               │                                                       │
│               └── Resource Group                                      │
│                       │                                               │
│                       └── Azure Resources                             │
└───────────────────────────────┬───────────────────────────────────────┘
                                │
                                │ avaliação
                                ▼
                     ┌───────────────────────┐
                     │      Azure Policy     │
                     │                       │
                     │ Policy Definition     │
                     │ Policy Assignment     │
                     │ Evaluation            │
                     │ Compliance            │
                     └───────────┬───────────┘
                                 │
                                 ▼
                     ┌───────────────────────┐
                     │ Governance & Security │
                     │                       │
                     │ Audit / Deny / Modify │
                     │ Standards             │
                     │ Compliance            │
                     └───────────────────────┘
```

A arquitetura demonstra uma separação importante:

> **RBAC controla permissões. Azure Policy controla requisitos e conformidade.**

Os mecanismos trabalham juntos, mas possuem responsabilidades diferentes.

---

# 🔐 Azure RBAC

O **Azure Role-Based Access Control (RBAC)** permite administrar o acesso aos recursos Azure através de funções.

O modelo pode ser representado como:

```text
┌──────────────┐
│  Identidade  │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Role         │
│ Assignment   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Role         │
│ Definition   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│    Scope     │
└──────────────┘
```

## Escopos

As permissões podem ser aplicadas em diferentes níveis:

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

Quanto mais amplo o escopo, maior deve ser o cuidado com a atribuição.

### Princípio do menor privilégio

Uma identidade deve receber somente as permissões necessárias para realizar suas atividades.

Exemplos de funções conhecidas:

* Reader
* Contributor
* Owner

A escolha da função deve considerar a responsabilidade real da identidade.

---

# 🛡️ Azure Policy

O **Azure Policy** é utilizado para criar e aplicar regras de governança sobre recursos Azure.

Uma política pode avaliar se os recursos estão de acordo com determinados requisitos.

### Estrutura conceitual

```text
Policy Definition
       │
       ▼
Policy Assignment
       │
       ▼
Resource Evaluation
       │
       ▼
Compliance State
```

## Policy Definition

Define a regra que será avaliada.

## Policy Assignment

Determina onde a política será aplicada.

## Compliance

Representa o resultado da avaliação dos recursos dentro do escopo.

---

# ⚙️ Efeitos de uma Policy

Entre os efeitos utilizados pelo Azure Policy estão:

| Efeito              | Finalidade                                                     |
| ------------------- | -------------------------------------------------------------- |
| `Audit`             | Identifica configurações fora do padrão                        |
| `Deny`              | Impede operações que violem determinada regra                  |
| `Modify`            | Modifica determinadas propriedades quando suportado            |
| `DeployIfNotExists` | Pode implantar configurações auxiliares em cenários suportados |

### Estratégia recomendada

Para novos controles de governança:

```text
Criar Policy
     ↓
Testar
     ↓
Audit
     ↓
Avaliar impacto
     ↓
Corrigir desvios
     ↓
Considerar controles mais restritivos
```

Começar com auditoria reduz o risco de bloquear cargas legítimas antes que o impacto da regra seja compreendido.

---

# 🏷️ Governança através de Tags

Tags são uma ferramenta importante para organização e governança.

Uma estratégia de laboratório pode utilizar:

| Tag           | Exemplo     |
| ------------- | ----------- |
| `Environment` | `lab`       |
| `Project`     | `az900`     |
| `Owner`       | `student`   |
| `CostCenter`  | `training`  |
| `ManagedBy`   | `azure-cli` |

As tags podem ajudar em:

* organização;
* identificação de recursos;
* análise de custos;
* responsabilização;
* automação;
* governança.

> **Importante:** tags não substituem mecanismos de segurança, RBAC ou autenticação.

---

# 🧪 Laboratório Prático

O projeto contém scripts para automatizar as principais etapas do laboratório.

## Pré-requisitos

Antes de começar:

* Conta Azure ativa;
* Subscription disponível;
* Azure CLI instalado;
* usuário autenticado;
* permissões adequadas no escopo utilizado.

### Verificar instalação

```bash
az version
```

### Autenticar

```bash
az login
```

### Verificar contexto

```bash
az account show --output table
```

---

# 🚀 Execução

## 1. Listar políticas

```bash
./scripts/listar-politicas.sh
```

O script apresenta definições de políticas disponíveis no ambiente.

---

## 2. Criar laboratório

```bash
./scripts/deploy-policy-lab.sh
```

O script cria um Resource Group destinado ao laboratório e realiza a atribuição de uma política de auditoria relacionada a tags.

Configuração padrão:

```text
Resource Group: rg-policy-az900
Policy: require-environment-tag
Tag: Environment
```

Esses valores podem ser alterados por variáveis de ambiente.

Exemplo:

```bash
RG=meu-resource-group LOCATION=eastus ./scripts/deploy-policy-lab.sh
```

---

## 3. Verificar conformidade

```bash
./scripts/check-compliance.sh
```

O script consulta as atribuições de Policy e tenta obter o estado de conformidade do laboratório.

Também é possível acompanhar pelo:

```text
Azure Portal
   ↓
Policy
   ↓
Compliance
```

---

## 4. Limpeza

Depois de concluir o laboratório:

```bash
./scripts/cleanup.sh
```

O script solicita uma confirmação explícita antes da exclusão.

```text
Digite DELETE para confirmar:
```

Isso reduz o risco de executar uma exclusão acidental.

---

# 🔬 Cenário de Teste

## Cenário A — Recurso sem tag

Um recurso é criado sem:

```text
Environment = lab
```

A política de auditoria pode identificar a configuração como não conforme após sua avaliação.

---

## Cenário B — Recurso com tag

O recurso recebe:

```text
Environment = lab
```

Após a avaliação da Policy, o estado de conformidade pode ser comparado com o cenário anterior.

### Fluxo

```text
Recurso
   │
   ▼
Azure Policy
   │
   ▼
Avaliação
   │
   ├── Conforme
   │
   └── Não conforme
```

> A avaliação das políticas pode não acontecer imediatamente. Em determinados cenários é necessário aguardar a avaliação ou solicitar uma reavaliação.

---

# 📊 Compliance

A análise de conformidade é uma etapa essencial do processo de governança.

O objetivo não é apenas criar políticas, mas compreender:

* quais recursos estão conformes;
* quais estão fora do padrão;
* qual política foi aplicada;
* qual recurso apresentou desvio;
* qual ação corretiva deve ser tomada.

### Ciclo de conformidade

```text
Definir requisito
       ↓
Criar Policy
       ↓
Atribuir Policy
       ↓
Avaliar recursos
       ↓
Identificar desvios
       ↓
Corrigir
       ↓
Reavaliar
```

---

# 🔄 Policy x RBAC

Uma das principais lições deste laboratório é compreender a diferença entre os dois mecanismos.

| Pergunta                                   | Tecnologia         |
| ------------------------------------------ | ------------------ |
| Quem é a identidade?                       | Microsoft Entra ID |
| Quem pode executar determinada ação?       | Azure RBAC         |
| Onde a permissão é válida?                 | RBAC Scope         |
| Qual configuração é permitida ou desejada? | Azure Policy       |
| O recurso está conforme?                   | Policy Compliance  |

### Resumo

```text
Microsoft Entra ID
        │
        ▼
     Identidade
        │
        ▼
      RBAC
        │
        ▼
"Quem pode fazer o quê?"

             +

      Azure Policy
        │
        ▼
"Quais requisitos devem ser atendidos?"
```

---

# 🛡️ Segurança

Este projeto adota princípios fundamentais de segurança em cloud.

### Menor privilégio

Conceder apenas as permissões necessárias.

### Escopo controlado

Evitar atribuições excessivamente amplas sem necessidade.

### Auditoria antes de bloqueio

Avaliar o impacto de uma política antes de aplicar controles restritivos.

### Separação de responsabilidades

Diferenciar identidade, permissões, governança e conformidade.

### Proteção de informações

Nunca publicar:

```text
❌ Senhas
❌ Tokens
❌ Client Secrets
❌ Chaves privadas
❌ Credenciais
❌ Informações confidenciais
```

---

# 📂 Estrutura do Projeto

```text
dio-gerenciando-politicas-acessos-azure/
│
├── README.md
│
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

# 📚 Documentação Complementar

| Documento                                 | Conteúdo                                  |
| ----------------------------------------- | ----------------------------------------- |
| [`azure-policy.md`](docs/azure-policy.md) | Conceitos e funcionamento do Azure Policy |
| [`rbac.md`](docs/rbac.md)                 | Controle de acesso e menor privilégio     |
| [`governanca.md`](docs/governanca.md)     | Estratégias de governança e conformidade  |
| [`checklist.md`](docs/checklist.md)       | Checklist de execução e evidências        |

---

# 📸 Evidências

Para transformar o laboratório em uma documentação completa de execução, recomenda-se adicionar evidências reais, como:

* Policy Assignment;
* Policy Definition;
* Compliance;
* Resource Group;
* recurso avaliado;
* configurações de tags;
* saída dos scripts;
* RBAC;
* resultado dos testes.

### Exemplo de organização

```text
docs/
└── evidencias/
    ├── 01-policy-assignment.png
    ├── 02-compliance.png
    ├── 03-resource-tags.png
    └── 04-rbac.png
```

> As imagens devem representar somente recursos e resultados realmente executados.

---

# 📈 Possíveis Evoluções

Este laboratório pode ser expandido para cenários mais próximos de ambientes corporativos.

### Próximos passos

* Criar iniciativas com múltiplas políticas;
* Utilizar políticas customizadas;
* Trabalhar com Management Groups;
* Integrar Azure Policy com Azure Resource Graph;
* Automatizar compliance;
* Integrar governança com CI/CD;
* Utilizar Azure Policy as Code;
* Integrar processos de FinOps;
* Criar dashboards de conformidade;
* Implementar políticas de segurança mais avançadas.

---

# 🧠 Principais Aprendizados

Durante o desenvolvimento deste projeto, os principais conceitos consolidados foram:

### Governança não é apenas segurança

Ela envolve organização, padronização, conformidade, custos, responsabilidades e controle.

### RBAC e Policy possuem funções diferentes

RBAC controla **permissões**.

Policy controla **requisitos e conformidade**.

### Escopo é fundamental

Uma política ou permissão pode ter impacto muito diferente dependendo de onde é aplicada.

### Auditoria é uma etapa importante

Antes de bloquear configurações, é importante entender o impacto da regra.

### Automação aumenta a consistência

Scripts Azure CLI permitem repetir processos de forma padronizada.

---

# 🧩 Competências Demonstradas

```text
Cloud Computing
      │
      ├── Azure Governance
      │
      ├── Azure Policy
      │
      ├── Azure RBAC
      │
      ├── Identity & Access
      │
      ├── Compliance
      │
      ├── Security
      │
      └── Azure CLI
```

---

# 📝 Conclusão

O projeto **Gerenciando Políticas em Acessos Azure** demonstra como mecanismos de identidade, controle de acesso e governança podem trabalhar de forma complementar dentro de uma arquitetura Azure.

A combinação de **Microsoft Entra ID, Azure RBAC e Azure Policy** permite construir uma abordagem estruturada para controlar identidades, limitar permissões, estabelecer padrões e acompanhar a conformidade dos recursos.

Mais do que simplesmente configurar uma política, o laboratório reforça um processo contínuo:

> **Definir → Aplicar → Avaliar → Corrigir → Monitorar → Evoluir**

Esse ciclo é fundamental para ambientes cloud que precisam equilibrar **segurança, governança, conformidade, produtividade e escalabilidade**.

---

# 📖 Referências

* Microsoft Learn — Azure Policy
* Microsoft Learn — Azure RBAC
* Microsoft Learn — Azure Governance
* Microsoft Learn — Microsoft Entra ID
* Microsoft Learn — Azure CLI
* Formação Microsoft Azure – AZ-900 Certification — DIO

---

# 👨‍💻 Autor

**Larwargrjr**

Projeto desenvolvido como parte da formação:

**Microsoft Azure – AZ-900 Certification**

---

<div align="center">

### ☁️ Azure Governance Lab

**Governança • Segurança • Identidade • Compliance • Automação**

⭐ Se este projeto foi útil para seus estudos, considere deixar uma estrela no repositório.

</div>
