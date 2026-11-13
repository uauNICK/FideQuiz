# ✝️ FideQuiz — O Quiz da Fé Católica

**FideQuiz** é um jogo multiplataforma (Android, iOS e Web/PWA) de perguntas e respostas sobre a fé católica, história da Igreja, Santos, Anjos, Bíblia e Doutrina.

---

## ✨ Funcionalidades Principais

### 1. Desbloqueio de Figuras Sagradas & Curiosidades (Exclusivo)
- A cada resposta correta, o jogador é agraciado com a **imagem sacra daquele Santo, Anjo ou Figura Católica** associada à questão.
- Logo abaixo da imagem, é apresentada uma **Curiosidade Histórica/Devocional** ("Você Sabia?"), além da explicação teológica e citação da fonte (Bíblia ou Catecismo da Igreja Católica).

### 2. Temas & Níveis Selecionáveis
- **3 Níveis de Dificuldade**:
  - 🌱 **Iniciante (Fácil)**: 10 pontos base
  - 🕯️ **Devoto (Médio)**: 20 pontos base
  - 📜 **Doutor da Fé (Difícil)**: 30 pontos base
- **Temas Disponíveis**:
  - 📖 Catequese Geral & Doutrina
  - 😇 Santos e Santas
  - 👼 Anjos e Arcanjos
  - 👑 Vida de Figuras Católicas (Padres da Igreja, Doutores, Papas e Mártires)
  - 📜 Bíblia Sagrada (Antigo e Novo Testamento)
  - ⛪ Liturgia & Sacramentos
  - 🛡️ Batalha Espiritual & Exorcismo
  - ✨ Tradição e Curiosidades

### 3. Rankings Competitivos ("Apimentando a Disputa")
- 🏆 **Ranking Diário**: renova todos os dias à meia-noite para novas disputas.
- 📅 **Ranking Semanal**: corrida semanal com pódio especial.
- 📆 **Ranking Mensal**: coroação dos maiores conhecedores do mês.
- 🌍 **Ranking Geral**: pontuação acumulada histórica.

### 4. Monetização Integrada
- **Google AdMob**: Banners, Interstitials a cada 3 partidas e Vídeos Recompensados.
- **Google AdSense**: Suporte na versão web.

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão >= 3.2.0)
- [Node.js](https://nodejs.org/) & Firebase CLI (opcional, para deploys na nuvem)

### 1. Instalar Dependências
```bash
flutter pub get
```

### 2. Executar no Navegador (Web / Computador)
```bash
flutter run -d chrome
```

### 3. Executar no Celular (Android / Emulador)
```bash
flutter run -d android
```

### 4. Gerar Build para Publicação
- **Web (PWA / Navegador)**:
  ```bash
  flutter build web
  ```
- **Android APK**:
  ```bash
  flutter build apk --release
  ```
- **Android App Bundle (Google Play Store)**:
  ```bash
  flutter build appbundle --release
  ```

---

## 📁 Estrutura de Código

```
FideQuiz/
├── lib/
│   ├── config/          # Temas litúrgicos, constantes e rotas
│   ├── models/          # Modelos Question (com figureName, figureCuriosity), UserProfile, QuizResult
│   ├── providers/       # Gerenciamento de estado (Auth, Quiz, Leaderboard)
│   ├── screens/         # Telas (Splash, Home, Category, Quiz, Result, Leaderboard, Profile, Login)
│   ├── services/        # Firebase Auth, Firestore, AdService, QuizService
│   └── widgets/         # Componentes visuais (FigureRewardDialog, QuestionCard, TimerWidget, etc.)
├── assets/
│   └── data/
│       └── questions.json # Banco de perguntas com figuras e curiosidades
├── android/             # Configuração nativa Android com AdMob
└── web/                 # PWA e entry point web
```

---
*Deo Gratias!* 🙏
