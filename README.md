# 🎮 Gameficação

Uma aplicação de lista de tarefas gamificada construída com **Ruby on Rails 8**, onde completar tarefas rende XP, sobe de nível, desbloqueia conquistas e mantém sequências diárias.

## Funcionalidades

- **Sistema de XP e Níveis**: Ganhe XP ao completar tarefas, suba de nível e ganhe títulos (Iniciante → Deus)
- **Dificuldades**: Fácil (10 XP), Médio (25 XP), Difícil (50 XP), Lendário (100 XP)
- **Conquistas**: 17 conquistas desbloqueáveis com bônus de XP
- **Sequência Diária (Streak)**: Mantenha uma sequência de dias consecutivos
- **Troca de Tema**: Tema claro/escuro + 6 paletas de cores (purple, blue, green, orange, red, pink)
- **Interface Reativa**: Atualizações em tempo real com Turbo Streams sem recarregar a página
- **Animações**: Popup de XP, level-up celebration, transições suaves

## Stack

| Tecnologia | Versão |
|------------|--------|
| Ruby | 3.3.x |
| Rails | 8.1.x |
| PostgreSQL | 16 |
| Tailwind CSS | 4.x |
| Stimulus | 3.x |
| Turbo | 8.x |

---

## Setup Local

### Pré-requisitos

- Ruby 3.3+ (recomendado via [rbenv](https://github.com/rbenv/rbenv) ou [asdf](https://github.com/asdf-vm/asdf))
- Docker e Docker Compose (para o PostgreSQL)
- Bundler (`gem install bundler`)

### 1. Clone o repositório

```bash
git clone https://github.com/danielcdamas/gameficacao.git
cd gameficacao
```

### 2. Instale as dependências Ruby

```bash
bundle install
```

### 3. Suba o PostgreSQL com Docker

```bash
docker compose up -d db
```

Aguarde o banco ficar pronto:

```bash
docker compose exec db pg_isready -U gameficacao
# gameficacao/localhost:5432 - accepting connections
```

### 4. Configure as variáveis de ambiente (opcional)

O projeto usa valores padrão que funcionam com o Docker Compose. Se quiser sobrescrever:

```bash
# .env (opcional)
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=gameficacao
DB_PASSWORD=gameficacao_secret
```

### 5. Crie e configure o banco de dados

```bash
rails db:create
rails db:migrate
rails db:seed
```

O seed cria:
- **17 conquistas** com diferentes raridades
- **Usuário demo**: `demo@gameficacao.com` / `demo123456`

### 6. Inicie a aplicação

```bash
bin/dev
```

A aplicação estará disponível em `http://localhost:3000`

> `bin/dev` usa o Foreman para rodar o servidor Rails + o compilador do Tailwind CSS em paralelo.

---

## Variáveis de Ambiente

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `DB_HOST` | `localhost` | Host do PostgreSQL |
| `DB_PORT` | `5432` | Porta do PostgreSQL |
| `DB_USERNAME` | `gameficacao` | Usuário do banco |
| `DB_PASSWORD` | `gameficacao_secret` | Senha do banco |

---

## Estrutura do Projeto

```
app/
├── controllers/
│   ├── dashboard_controller.rb     # Página inicial com stats
│   ├── tasks_controller.rb         # CRUD de tarefas + completar
│   ├── achievements_controller.rb  # Lista de conquistas
│   ├── sessions_controller.rb      # Login/logout
│   ├── users_controller.rb         # Registro + perfil
│   └── themes_controller.rb        # Troca de tema/cor
├── models/
│   ├── user.rb                     # Usuário com sistema de XP/níveis
│   ├── task.rb                     # Tarefa com dificuldades
│   ├── achievement.rb              # Conquistas
│   └── user_achievement.rb         # Relação usuário-conquista
├── services/
│   └── achievement_service.rb      # Lógica de check/award de conquistas
├── javascript/controllers/
│   ├── dropdown_controller.js      # Menus dropdown
│   ├── flash_controller.js         # Auto-dismiss de notificações
│   ├── xp_notification_controller.js # Animação de XP ganho
│   ├── task_form_controller.js     # Seletor de dificuldade
│   └── theme_controller.js         # Aplicação de tema
└── views/
    ├── dashboard/index.html.erb    # Dashboard com stats e preview
    ├── tasks/                      # CRUD de tarefas
    ├── achievements/index.html.erb # Galeria de conquistas
    └── shared/                     # Navbar, user stats, notificações
```

---

## Sistema de Gamificação

### XP e Níveis

| Dificuldade | XP | Emoji |
|-------------|-----|-------|
| Fácil | 10 XP | ⚡ |
| Médio | 25 XP | 🔥 |
| Difícil | 50 XP | 💎 |
| Lendário | 100 XP | ⭐ |

| Nível | XP Total Necessário | Título |
|-------|-------------------|--------|
| 1-2   | 0–249 | Iniciante |
| 3-5   | 250–849 | Aventureiro |
| 6-9   | 850–2699 | Herói |
| 10-14 | 2700–9999 | Campeão |
| 15-19 | 10000–19999 | Lenda |
| 20-29 | 20000–34999 | Mestre |
| 30-39 | 35000–99999 | Grão-Mestre |
| 40-49 | 100000+ | Imortal |
| 50+   | 175000+ | Deus |

### Conquistas

**Por tarefas completadas**: Primeira Missão, Começando Bem, Em Ritmo, Produtivo, Máquina de Tarefas, Centenário, Lenda Viva

**Por sequência (streak)**: Consistente (3d), Semana Perfeita (7d), Imparável (30d), Dedicação Total (100d)

**Por nível**: Evoluindo (5), Herói Emergente (10), Mestre Supremo (20)

**Por dificuldade**: Corajoso (5 difíceis), Lendário (1 lendária), Caçador de Lendas (10 lendárias)

---

## Troca de Tema

O tema é persistido por usuário no banco de dados:

- **Modo escuro/claro**: Toggle na navbar
- **Cor do tema**: 6 opções (purple, blue, green, orange, red, pink)
- As preferências são aplicadas via Turbo Streams sem recarregar a página

---

## Comandos Úteis

```bash
# Rodar migrações
rails db:migrate

# Popular banco com conquistas e usuário demo
rails db:seed

# Compilar Tailwind
rails tailwindcss:build

# Console interativo
rails console

# Verificar rotas
rails routes

# Ver logs
tail -f log/development.log
```

---

## Licença

MIT
