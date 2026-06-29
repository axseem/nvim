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

Use `${1:name}` for the first tab stop with placeholder text, `${2:name}` for the next one, and `${0}` for the final cursor position.

References:

- [VS Code snippets syntax](https://code.visualstudio.com/docs/editing/userdefinedsnippets#_snippet-syntax)
- [Blink snippets docs](https://cmp.saghen.dev/configuration/snippets.html)
