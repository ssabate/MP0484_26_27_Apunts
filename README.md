# Oracle SQL · Combinacions i funcions

Lliçó en Markdown en català, construïda amb Jekyll per a GitHub Pages, sobre operacions de conjunts, funcions d’Oracle SQL, funcions d’agregació i l’esquema de mostra HR. Inclou els exercicis originals i una nova sèrie; les solucions de la sèrie nova són exclusivament a `solutions/exercicis-hr-solucions.sql`.

## Publicació a GitHub Pages

El workflow `.github/workflows/pages.yml` construeix el lloc amb Jekyll a cada canvi a `main` i també es pot executar manualment. A **Settings → Pages**, selecciona **GitHub Actions** com a font de publicació. Quan el primer workflow acabi, l’adreça del lloc apareixerà a l’entorn `github-pages` de l’execució.

La pàgina i la configuració de Jekyll són a `index.md`, `_config.yml` i `_layouts/default.html`. Per previsualitzar-la localment, instal·la Jekyll i inicia el servidor des de l’arrel del repositori:

```sh
gem install jekyll
jekyll serve
```

Les consultes SQL estan pensades per a una instal·lació Oracle amb accés a l’esquema HR. Cal executar-les en una sessió autoritzada a consultar les taules; el lloc web no es connecta a cap base de dades.
