# ☁️ Cloud Infrastructure - Multi-Cloud Management

Este repositório contém a Infraestrutura como Código (IaC) para o gerenciamento de ambientes multicloud (**AWS, OCI e Azure**), utilizando Terraform e scripts de automação em Python.

## 🏗️ Estrutura do Projeto

* **`/modules`**: Contém os blocos construtivos reutilizáveis (Ex: instâncias para Guardian/DefectDojo, VCNs, Security Groups).
* **`/dev`**: Configurações específicas para o ambiente de Laboratório/Desenvolvimento.
* **`repositories.tf`**: Definições globais de repositórios e recursos compartilhados.
* **Scripts Python**: Automações para relatórios de custos, inventário de servidores e revisão de acesso.

## 🌿 Estratégia de Branches

Seguimos um fluxo rigoroso para garantir a estabilidade das **26 contas AWS**:

1.  **`main`**: Reflete o ambiente de Produção. Somente merges via Pull Request.
2.  **`develop`**: Ambiente de Staging/Lab. Onde as integrações são testadas.
3.  **`feature/*`**: Desenvolvimento de novos recursos (ex: `feature/novo-server-guardian`).
4.  **`hotfix/*`**: Correções urgentes em produção.
5.  **`refactor/*`**: Melhorias de código sem alteração de recursos.

## 🚀 Como Utilizar

### Pré-requisitos
* Terraform v1.0+
* Python 3.10+
* AWS CLI & OCI CLI configurados (Princípio do Privilégio Mínimo).

### Iniciando o Ambiente de Dev
```bash
cd dev
terraform init
terraform plan