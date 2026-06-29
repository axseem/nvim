# Snippets

Add snippets in the `*.json` files and expose new files from `package.json`.

Aliases are just multiple prefixes:

```json
{
	"Log": {
		"prefix": ["log", "ll"],
		"body": "print(${1:value})",
		"description": "Print a value"
	}
}
```

Use `${1:name}` for tab stops and `${0}` for the final cursor position.
