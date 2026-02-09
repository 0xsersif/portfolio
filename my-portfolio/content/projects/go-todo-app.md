---
title: "Go Todo CLI/Web Tool"
date: 2025-09-10
description: "Minimal todo application built with Go standard library, featuring dark mode and glassmorphic UI"
tags: ["Go", "Full-Stack", "Web", "CLI"]
categories: ["Full-Stack"]
---

# Go Todo App

## Minimal CLI/Web Tool with Modern UI

A streamlined todo application built entirely with **Go's standard library**—no external dependencies. Demonstrates Go proficiency with a beautiful, minimal interface.

## Philosophy

Chose standard library over frameworks to:
- Maintain authenticity and learning
- Zero dependencies (easy deployment)
- Understand HTTP servers from first principles
- Keep codebase minimal and fast

## Features

✅ **Dark Mode** — Default beautiful dark theme  
✅ **Glassmorphic UI** — Modern frosted glass effects  
✅ **Inline Editing** — Click to edit tasks directly  
✅ **Priority Management** — High/Medium/Low priorities  
✅ **Local Storage** — Persist tasks in JSON file  
✅ **CLI Mode** — Use from terminal or web browser

## Tech Stack

- **Go (stdlib only)** — `net/http`, `encoding/json`, `html/template`
- **Modern CSS** — Custom glassmorphism, dark mode
- **Vanilla JavaScript** — No jQuery, no React, pure JS
- **No Database** — Simple JSON file storage

## Code Highlights

### HTTP Server (stdlib only)

```go
package main

import (
    "encoding/json"
    "html/template"
    "net/http"
    "os"
)

type Todo struct {
    ID       int    `json:"id"`
    Title    string `json:"title"`
    Done     bool   `json:"done"`
    Priority string `json:"priority"`
}

func main() {
    http.HandleFunc("/", homeHandler)
    http.HandleFunc("/api/todos", todosHandler)
    http.HandleFunc("/static/", staticHandler)
    
    log.Println("Server starting on :8080")
    http.ListenAndServe(":8080", nil)
}
```

### Glassmorphic CSS

```css
.todo-card {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
}
```

## UI Design

**Color Scheme**:
- Background: `#0a0e27` (deep blue-black)
- Accent: `#667eea` → `#764ba2` (purple gradient)
- Glass: `rgba(255, 255, 255, 0.1)` with blur

**Typography**:
- Headers: `Inter` (Google Fonts)
- Mono: `JetBrains Mono` for code

**Animations**:
- Smooth hover transitions (200ms)
- Task completion fade effect
- Priority badge color shifts

## Live Demo

🚀 **[Try it Live →](https://go-todo-demo.0xmuler.dev)**

## GitHub Repository

📂 **[View Source Code →](https://github.com/0xmuler/go-todo-app)**

Features:
- Clean, documented Go code
- No external dependencies
- Docker support
- Professional README

## Why Go Standard Library?

**Learning Value**:
- Understand HTTP servers deeply
- Master Go interfaces and concurrency
- No framework magic, full control

**Production Benefits**:
- Fast compilation (<1s)
- Tiny binary (5MB)
- No dependency hell
- Easy deployment

## Deployment

### Binary (no dependencies)

```bash
go build -o todo
./todo
# Server runs on localhost:8080
```

### Docker

```dockerfile
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o todo

FROM alpine:latest
COPY --from=builder /app/todo /todo
CMD ["/todo"]
```

## Lessons Learned

1. **Standard library is powerful** — Don't need frameworks for simple apps
2. **CSS can be beautiful** — No need for component libraries
3. **Vanilla JS is fast** — React would be overkill here
4. **Simplicity scales** — Fewer dependencies = less maintenance

## Future Enhancements

- User authentication (SQLite + JWT)
- Due dates and reminders
- Tags and categories
- Sync across devices (WebSocket)
