#!/usr/bin/env bash
# Деплой карты ярмарки на GitHub Pages
# Использование: ./update.sh ["сообщение коммита"]

set -e

SITE_DIR="/Users/mac/Desktop/yarmarka-site"
SRC_FILE="/Users/mac/Desktop/yarmarka-map.html"
URL="https://maximkremenchug-spec.github.io/yarmarka-map/"

cd "$SITE_DIR"

if [ ! -f "$SRC_FILE" ]; then
  echo "❌ Исходник не найден: $SRC_FILE"
  exit 1
fi

cp "$SRC_FILE" "$SITE_DIR/index.html"

if git diff --quiet index.html; then
  echo "✓ Изменений нет — деплой не требуется."
  exit 0
fi

MSG="${1:-update $(date '+%Y-%m-%d %H:%M')}"

echo "📤 Коммит и пуш..."
git add index.html
git commit -m "$MSG"
git push

echo ""
echo "✅ Готово! Через ~30-60 сек обновится:"
echo "   $URL"
