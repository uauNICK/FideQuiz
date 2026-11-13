#!/bin/bash
set -e

echo "=== 1. Instalando Flutter SDK na Vercel ==="
if [ ! -d "_flutter" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable _flutter
fi

export PATH="$PATH:$(pwd)/_flutter/bin"

echo "=== 2. Configurando Flutter Web ==="
flutter config --no-analytics
flutter config --enable-web

echo "=== 3. Baixando Dependências do FideQuiz ==="
flutter pub get

echo "=== 4. Compilando App para Web (Release) ==="
flutter build web --release

echo "=== Build concluído com sucesso! Pasta build/web gerada ==="
