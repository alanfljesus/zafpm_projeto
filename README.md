# Gerenciador de Projetos SAP

Este repositório contém o código-fonte do Gerenciador de Projetos desenvolvido para o ambiente SAP utilizando ABAP. Este sistema permite o gerenciamento de projetos, equipes, tickets, arquivos, apontamento de horas, comentários e notificações, tudo integrado no SAP GUI e Fiori Elements.

## Funcionalidades

- **Gerenciamento de Projetos:** Criação e gerenciamento de projetos, com atribuição de equipes.
- **Gestão de Equipes:** Associação de usuários SAP a projetos específicos, com perfis personalizados.
- **Tickets:** Registro e gerenciamento de atividades (tickets) associadas aos projetos.
- **Arquivos:** Upload e gerenciamento de arquivos relacionados aos tickets.
- **Horas:** Apontamento de horas trabalhadas pelos usuários em cada ticket.
- **Comentários:** Adição de comentários em tickets, permitindo o acompanhamento do progresso.
- **Notificações:** Notificação automática da equipe vinculada ao ticket quando há um novo upload, apontamento de horas ou comentário.

## Estrutura do Projeto

### Pacotes

- **ZAFPM:** Pacote principal que organiza todos os módulos do projeto.
  
  **Módulos - Subpacotes:**
  - **Cross Application**: Todos os objetos que são utilizados por mais de um módulo.
  - **Projeto:**
    - **Equipe:** Gerenciamento das equipes atribuídas a cada projeto.
    - **Perfil:** Gestão dos perfis dos usuários dentro das equipes.
  - **Tickets:**
    - **Arquivos:** Módulo para upload e gestão de arquivos.
    - **Horas:** Módulo para apontamento e gestão de horas.
    - **Comentários:** Módulo para adicionar e gerenciar comentários nos tickets.
    - **Notificações:** Módulo para envio de notificações automáticas para a equipe.
    
### O que foi usado?

- **SM30**
- **Module Pool**
- **Classes ABAP**
- **Testes Unitários**
- **Cluster de Visão**
- **Code Inspector (SCI)**
- **ALV**
- **CDS Views**
- **Fiori Elements**
