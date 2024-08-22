# SAP Gerenciador de Projetos

Este repositório contém um Gerenciador de Projetos desenvolvido dentro do SAP, totalmente em ABAP. O projeto abrange funcionalidades para gerenciamento de projetos, equipes, perfis de usuários e tickets, horas trabalhadas, comentários, e notificações.

## Estrutura do Projeto

### Pacotes e Requests

A estrutura do projeto é organizada em pacotes principais e módulos específicos:

- **ZAFPM - Principal**: Pacote principal do projeto.

#### Subpacotes

1. **Projeto**:
   - Gerenciamento de projetos, definição de metas e milestones.
   - Atribuição de equipes e recursos.

2. **Equipe**:
   - Gerenciamento de membros da equipe, definição de papéis e responsabilidades.

3. **Perfil**:
   - Gestão de perfis de usuários, incluindo permissões e acessos.

4. **Tickets**:
   - Gerenciamento de tarefas e issues no projeto.
   - Submódulos:
     - **Arquivos**: Anexar documentos e arquivos relevantes aos tickets.
     - **Horas**: Registro e monitoramento de horas trabalhadas.
     - **Comentários**: Comunicação entre a equipe diretamente nos tickets.
     - **Notificações**: Alertas e notificações automáticas sobre mudanças de status ou outras atualizações importantes.

5. **Cross Application**:
   - Aplicação que contém objetos e funcionalidades compartilhadas entre os diferentes subpacotes do sistema, permitindo reutilização de código e manutenção simplificada.
