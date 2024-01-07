source ~/.config/awesome/configuration/ui/notion/config.sh

TITLE=$(rofi -dmenu -p "Enter title:" -config "~/.config/awesome/configuration/ui/notion/create_task.rasi")

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
