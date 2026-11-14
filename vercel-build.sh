#!/usr/bin/env bash
set -e

echo "=== 1. Instalando Flutter SDK na Vercel ==="
if [ ! -d "_flutter" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable _flutter
fi

export PATH="$PATH:$(pwd)/_flutter/bin"
export FLUTTER_ROOT="$(pwd)/_flutter"

echo "=== 2. Habilitando Web ==="
flutter config --no-analytics
flutter config --enable-web

echo "=== 3. Baixando Dependencias ==="
flutter pub get

echo "=== 4. Compilando FideQuiz Web ==="
flutter build web --release --no-tree-shake-icons

echo "=== 5. Sucesso! Build finalizado em build/web ==="