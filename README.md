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

Go to https://lfs.freding.no/slfs/ og begynne å bla gjennom boken!

Nettboken er under rullende utgivelse, men det finnes en stabil versjon i SLFS
kildekoden via stable grenen. Du kan bytte til den ved å kjøre følgende 
kommando:

```Bash
git checkout stable
```

Gjengi deretter boken med `make STAB=release [andre alternativer]`.

Det finnes også [releases](https://github.com/glfs-book/slfs/releases) available
tilgjengelig for nedlasting. Disse inneholder både SysV og Systemd utgavene av 
boken som chunked HTML. Disse er på Engelsk.

## Installasjon

Hvordan konverterer jeg disse XML filene til HTML selv? Du må ha installert 
programvare som håndterer disse konverteringene. Vennligst les
[INSTALL.md](./INSTALL.md) for å finne ut hvilke programmer du må installere og 
hvor du kan få instruksjoner for å installere programvaren.

Du kan deretter bygge HTML koden med en enkel `make` kommando. Du kan endre
revisjonen ved å sende `REV=<rev>` til `make` kommandoen. `<rev>` kan være:
- `sysv` (default)
- `systemd`

Eksempel: `make REV=systemd`

Du kan bytte tema ved å sende `THEME=<theme>` til `make` kommandoen.
`<theme>` kan være lik:
- `dark` (standard)
- `light`
- hvilket som helst tema i `THEME_PATH`

Eksempel: `make THEME=dark`

Du kan angi temabanen ved å sende `THEME_PATH=<path>` til `make` kommandoen.
Standard er `stylesheets/lfs-xsl`. Flere temaer er tilgjengelige påFlere temaer er tilgjengelige på
https://github.com/glfs-book/lfs-themes.

Eksempel: `make THEME_PATH=../lfs-themes/themes THEME=whitepink`

Standardmålet (sysv) bygger HTML koden i `~/public_html/slfs`,
mens for systemd ville det være i `~/public_html/slfs-systemd`.
Som standard vil hver pakke og seksjon være sin egen side, og deretter kobles 
alt sammen for en smidig opplevelse.

Det finnes også flere variabler som kan angis, som kan brukes til å spesifisere 
hvor den gjengitte utdataen skal være, hvor midlertidige filer befinner seg, 
stabilitetstypen til gjengivelsen og mer.

En viktig ting å være klar over er hva som er satt som standard RENDERTMP
(`mktemp -d` (som standard) vil bli fjernet etter at hver fil har blitt 
konvertert til et nytt format (HTML, wget-list, kommandoskript osv.) som 
standard. Hvis du trenger å beholde mappen av en eller annen grunn, send 
`AUTO_CLEAN=0` når `make` kjøres.

Eksempel: `make RENDERTMP=~/tmp AUTO_CLEAN=0`
