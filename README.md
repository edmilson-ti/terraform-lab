# ☁️ Cloud Infrastructure - AWS

Este repositório contém a Infraestrutura como Código (IaC) para o gerenciamento de ambientes AWS, utilizando Terraform.

## 🏗️ Estrutura do Projeto

* **`/modules`**: Contém os blocos construtivos reutilizáveis (Ex: ECS, VPC).
* **`/dev`**: Configurações específicas para o ambiente de Laboratório/Desenvolvimento.
* **`repositories.tf`**: Repositorios para armazenamento das imagens de containers.

## 🌿 Estratégia de Branches

Seguimos a seguinte estrutura de branchs

1.  **`main`**: Reflete o ambiente de Produção. Somente merges via Pull Request.
2.  **`develop`**: Ambiente de Desenvolvimento/Lab. Onde as integrações são testadas.
3.  **`feature/*`**: Desenvolvimento de novos recursos (ex: `ECS, ALB, ECR, etc...`).
4.  **`hotfix/*`**: Correções urgentes em produção.
5.  **`refactor/*`**: Melhorias de código sem alteração de recursos.

## 🚀 Como Utilizar

### Pré-requisitos
* Visual Studio Code
* Terraform v1.0+
* Python 3.10+
* AWS CLI & OCI CLI configurados (Princípio do Privilégio Mínimo).

### Iniciando o Ambiente de Dev
```bash
cd dev
terraform init
terraform plan
