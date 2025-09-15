# Supplemental Linux From Scratch (SLFS)

Denne boken er dedikert til å supplere en LFS, MLFS, BLFS og/eller GLFS x86-64 
system ved å tilby pakker som ikke finnes i de andre LFS-bøkene.

Denne boken kan skryte av flere biblioteker og verktøy som ikke er dekket i 
`*LFS` bøkene. I tillegg til dette gir den også: SVR4 relatert verktøy, støtte 
for kun binære applikasjoner, mange grafiske miljøer for både Wayland og X.org, 
emulatorer for både datamaskiner og spillkonsoller, generell spillprogramvare og 
mer.

# Hvor man kan lese

Gå til https://glfs-book.github.io/slfs/ og begynn å bla gjennom boken!

Boken er under rullende utgivelse på nett, men det finnes en stabil versjon i 
SLFS kildekoden via den stabile grenen.

Du kan bytte til den ved å kjøre følgende kommando:

```Bash
git checkout stable
```

Gjengi deretter boken med `make STAB=release [andre alternativer]`.

Det finnes også [Releases](https://github.com/glfs-book/slfs/releases) som du 
kan laste ned. Alle inneholder både SysV og Systemd utgavene av boken, 
i delt HTML.

# Installasjon

Hvordan konverterer jeg disse XML filene til HTML? Du må ha installert 
programvare som håndterer disse konverteringene. Vennligst les `INSTALL.md` 
filen for å bestemme hvilke programmer du må installere og hvor du kan få 
instruksjoner for å installere programvaren.

Etter det kan du bygge HTML koden med en enkel `make` kommando. Du kan endre 
revisjonen, f.eks. systemd vs. sysv, ved å legge til `REV=<rev>` til `make` 
kommandoen. `<rev>` kan være:
- `sysv` (standard)
- `systemd`

Eksempel: `make REV=systemd`.

Standardmålet (sysv) bygger HTML koden i `~/public_html/slfs`,
mens for systemd ville det være i `~/public_html/slfs-systemd`.
Som standard vil hver pakke og seksjon være sin egen side, og deretter koble 
alt sammen for en smidig opplevelse.

Du kan angi en sti til temaene ved å kjøre `make THEME_PATH=<path>`. 
Standard er `stylesheets/lfs-xsl`. Du finner mer på
https://github.com/glfs-book/lfs-themes.

Det mørke temaet er også standard, men du kan bytte tema ved å
kjøre `make THEME=<theme>`. `<theme>` kan være lik:
- `light`
- `dark`

Note that if you set `THEME_PATH`, kan du sette `THEME` til mer enn bare det 
som er vist ovenfor, men bare de tilgjengelige temaene som er i den banen.
