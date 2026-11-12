# Oracle SQL · Combinacions i funcions

Lliçó web en català sobre operacions de conjunts, funcions predefinides d’Oracle SQL, funcions d’agregació i l’esquema de mostra HR. Inclou els exercicis originals i una nova sèrie; les solucions de la sèrie nova són exclusivament a `solutions/exercicis-hr-solucions.sql`.

## Publicació a GitHub Pages

El workflow `.github/workflows/pages.yml` publica el contingut estàtic del repositori a cada canvi a `main` i també es pot executar manualment. A **Settings → Pages**, selecciona **GitHub Actions** com a font de publicació. Quan el primer workflow acabi, l’adreça del lloc apareixerà a l’entorn `github-pages` de l’execució.

Per previsualitzar la pàgina localment, obre `index.html` al navegador o inicia un servidor estàtic a l’arrel del repositori, per exemple:

```sh
python3 -m http.server 8000
```

Les consultes SQL estan pensades per a una instal·lació Oracle amb accés a l’esquema HR. Cal executar-les en una sessió autoritzada a consultar les taules; el lloc web no es connecta a cap base de dades.
