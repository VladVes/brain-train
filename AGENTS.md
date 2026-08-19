# AGENTS.md

Справочник по ключевым решениям проекта **Brain-Train**.

## Overview

Brain-Train — веб-приложение для тренировки рабочей памяти через мысленный перевод
чисел между системами счисления. Репозиторий состоит из трёх независимых частей:
описание контракта API (`tsp/`), фронтенд (`client/`).

## Структура проекта

```
brain-train/
├── tsp/       # TypeSpec: контракт REST API → OpenAPI 3.1
├── client/    # React SPA (Vite + TypeScript)
├── LICENSE
└── AGENTS.md
```

- Каждый подпроект самодостаточен: свой `package.json` и свои `node_modules`.
- Корневого `package.json` нет — это не npm workspace.

## Инструменты и версии

- **Node.js** — управляется через `asdf` (текущая 26.6.0). Пакетный менеджер — **npm**.
- **TypeScript** — основной язык для клиента (и потенциальных эмиттеров).
- **TypeSpec** compiler — локально 1.15.0; глобальный shim asdf — 1.14.0.
- **Vite 8** — сборщик клиента. **React 19**.
- **oxlint** — линтер клиента.

## `tsp/` — контракт API

- Инициализирован из шаблона `rest`.
- Библиотеки: `@typespec/http`, `@typespec/rest`, `@typespec/openapi`, `@typespec/openapi3`.
- Эмиттер: `@typespec/openapi3` → **OpenAPI 3.1** в `tsp-output/schema/openapi.yaml`.
- Конфигурация: `tspconfig.yaml`. Точка входа — `main.tsp` (сейчас пуст, эндпоинты ещё не описаны).
- Команды (из `tsp/`):
  - `tsp compile .` — сборка и генерация OpenAPI.
  - `tsp compile . --watch` — пересборка при изменениях.

## `client/` — фронтенд

- Vite + React + TypeScript (шаблон `react-ts`).
- SPA с одной корневой страницей.
- Скрипты (`package.json`):
  - `dev` — dev-сервер Vite.
  - `build` — `tsc -b && vite build`.
  - `lint` — `oxlint`.
  - `preview` — предпросмотр production-сборки.
- Структура: `index.html`, `src/App.tsx`, `src/App.css`, `src/index.css`, `src/main.tsx`, `public/`.

## Стилизация UI

- Тема: **ретро-терминал** — чёрный фон `#000`, зелёный текст `#00ff00`.
- Шрифт: **VT323** (Google Fonts, подключён в `index.html`); fallback — `Courier New, monospace`.
- CRT-эффекты:
  - свечение текста через `text-shadow`;
  - оверлей-сканлайны через `repeating-linear-gradient` (`.scanlines`, `position: fixed`, `pointer-events: none`).
- Приёмы вёрстки:
  - заголовок сверху по центру;
  - контент центрируется по вертикали и горизонтали через flex;
  - текстовый блок шириной `25vw` (1/4 экрана);
  - ровный прямоугольник текста через `text-align: justify` + `text-align-last: justify`.
- Токены темы вынесены в CSS-переменные в `:root`: `--terminal-green`, `--terminal-bg`, `--terminal-glow`.

## Конвенции

- Комментарии и документация — на русском языке (технические термины допустимо оставлять на английском).
- Стилевые значения (цвета, свечение) держим в CSS-переменных для переиспользования.
