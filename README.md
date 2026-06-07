<div align="center">
  <img src="https://github.com/glfs-book/slfs/blob/trunk/images/slfs-logo.svg?raw=true" width="25%">
  <h1>SLFS</h1>
</div>

<h2 align="center">
Supplemental Linux From Scratch
</h2>

Denne boken supplerer et LFS, MLFS, BLFS og/eller GLFS x86-64 system ved å 
tilby pakker som ikke finnes i de andre LFS bøkene.

SLFS kan skryte av flere biblioteker og verktøy som ikke er dekket i de andre
 `*LFS` bøkene, inkludert SVR4-relatert verktøy, støtte for kun binære 
 applikasjoner, mange grafiske miljøer for både Wayland og X11, emulatorer, 
 spill og spillprogramvare, systemverktøy og mer.

## Hvor kan du lese den

Gå til https://lfs.freding.no/slfs/view/systemd/index.html eller
https://lfs.freding.no/slfs/ og begynne å bla gjennom boken!

Du finner flere nettkopier på https://linuxfromscratch.org/slfs/view/.

Det finnes også [releases](https://github.com/glfs-book/slfs/releases) 
tilgjengelig for nedlasting.

## Installasjon

Hvordan konverterer jeg disse XML filene til HTML selv? Du må ha installert 
programvare som håndterer disse konverteringene. Vennligst les
[INSTALL.md](./INSTALL.md) for å finne ut hvilke programmer du må installere og 
hvor du kan få instruksjoner for å installere programvaren.

Du kan deretter bygge HTML-koden med en enkel `make` kommando.

Du kan bytte tema ved å sende `THEME=<theme>` til `make` kommandoen.
`<theme>` kan være lik:
- `dynamic` (standard)
- `dark`
- `light`
- hvilket som helst tema i `THEME_PATH`

Eksempel: `make THEME=dark`

Du kan angi temabanen ved å sende `THEME_PATH=<path>` til `make` kommandoen.
Standard er `stylesheets/lfs-xsl`. Flere temaer er tilgjengelige påFlere temaer er tilgjengelige på
https://github.com/glfs-book/lfs-themes.

Eksempel: `make THEME_PATH=../lfs-themes/themes THEME=whitepink`

Standardmålet gjengir HTML koden i `~/public_html/slfs`.

Det finnes også flere variabler som kan angis, som kan brukes til å spesifisere 
hvor den gjengitte utdataen skal være, hvor midlertidige filer befinner seg, 
stabilitetstypen til gjengivelsen og mer.

En viktig ting å være klar over er hva som er satt som standard RENDERTMP
(`mktemp -d` (som standard) vil bli fjernet etter at hver fil har blitt 
konvertert til et nytt format (HTML, wget-list, kommandoskript osv.) som 
standard. Hvis du trenger å beholde mappen av en eller annen grunn, send 
`AUTO_CLEAN=0` når `make` kjøres.

Eksempel: `make RENDERTMP=~/tmp AUTO_CLEAN=0`
