source ~/.config/awesome/configuration/ui/rofi/notion/config.sh

TITLE=$(rofi -dmenu -p "Enter title:" -config "~/.config/awesome/configuration/ui/rofi/notion/create_task.rasi")

if [[ -n $TITLE ]]; then
  curl 'https://api.notion.com/v1/pages' \
    -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
    -H "Content-Type: application/json" \
    -H "Notion-Version: 2022-06-28" \
    --data '{
    "parent": { "database_id":  "'"$NOTION_DATABASE_ID"'"},
    "properties": {
      "Nombre de tarea": {
        "title": [
          {
            "text": {
              "content": "'"$TITLE"'"
            }
          }
        ]
      }
    }
  }'
fi
