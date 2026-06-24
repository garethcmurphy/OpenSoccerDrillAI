# Open Soccer Drill AI

Open Soccer Drill AI is now a React-based drill planning app built for the browser.

## What it includes

- Drill preset cards with setup notes and coaching points
- Movable player markers on a soccer pitch
- Drill detail panel with session flow and skills focus
- Vite-powered local development workflow
- GitHub Actions for CI and GitHub Pages deployment

## Run locally

```bash
npm install
npm run dev
```

## Validate locally

```bash
npm run lint
npm run build
```

## GitHub Pages deployment

The repository includes:

- `.github/workflows/ci.yml` for lint and build checks
- `.github/workflows/deploy-pages.yml` for GitHub Pages deployment on pushes to `main`

After enabling GitHub Pages in the repository settings, set the source to **GitHub Actions**.

## Legacy Swift project

The original Swift/iOS project is still present in the repository for reference, but the active app experience is now the React web app at the repository root.
