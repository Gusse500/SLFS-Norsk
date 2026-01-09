# Bidra

## 1. Grunnleggende
Først, vennligst les
[Linux From Scratch Editor's Manual](https://www.linuxfromscratch.org/lfs/LFS-EDITORS-GUIDE.html)
siden den inneholder noe god informasjon. Noe informasjon mangler, og noe er spesifikk for LFS.

Dette prosjektet er hovedsakelig skrevet i Docbook XML. De fleste problemene og 
oppdateringene gjelder XML-en som legges inn i den endelige teksten i den 
gjengitte boken. Hvis du ønsker å bidra på en eller annen måte, men ikke kjenner 
XML og/eller ikke ønsker å skrive noe XML, kan du legge inn problemene på.
[issues](https://github.com/glfs-book/slfs/issues).

Hvis du føler deg mer kyndig, bør du gjøre deg kjent med boken, hvordan den er 
skrevet, hvor viktige filer finnes, deretter oppdatere etter behov, og gi en PR. 
Denne delen krever en mer grundig forklaring og hvor den egentlig avviker fra 
LFS Editor's Manual. Hvis du er en BLFS-redaktør, vil redigering av denne
boken ikke være så annerledes. Les [del 2](#2-plassering) and
[del 3](#3-standarder) for SLFS-spesifikk informasjon.

## 2. Plassering
### 2.1. Interne filer og mapper
Før vi begynner med hoveddelen av boken og hva folk skal lese, må vi dekke 
filene og mappene til kilden til boken som er mer interne, men likevel 
essensielle.

I roten av kildekoden finner du disse filene og mappene:
- `.github/workflows/`
- `archive/`
- `images/`
- `kernel-config/`
- `patches/`
- `stylesheets/`
- `template/`
- `.gitattributes`
- `.gitignore`
- `INSTALL.md`
- `Makefile`
- `expand_date`
- `general.ent`
- `git-version.sh`
- `gnome.ent`
- `obfuscate.sh`
- `packages.ent`
- `tidy.conf`

#### 2.1.1. `.github/workflows/`
Denne mappen inneholder YAML filer som brukes av GitHub CI-er til å gjengi 
boken og legge den ut på SLFS nettstedet. Den trenger sjelden
oppdatering.
#### 2.1.2. `archive/`
Denne mappen inneholder XML filer som ikke lenger anses som nødvendige eller 
nyttige å inkludere i boken, men som flyttes dit i tilfelle de må hentes tilbake 
eller for studiets skyld. Filer som ikke samsvarer med nye standarder trenger 
ikke å oppdateres med mindre de bringes tilbake til 
boken.
#### 2.1.3. `images/`
Denne mappen inneholder bilder som brukes av boken, f.eks. for merknader, viktig 
informasjon, advarsel og tips bokser, samt for favorittikonet og bildet som 
vises øverst på hjemmesiden. Trenger sjelden å oppdateres.
#### 2.1.4. `kernel-config/`
Denne mappen inneholder filene som trengs for å generere 
kjernekonfigurasjonsblokker som du finner på sider som krever at du endrer 
konfigurasjonen i kjernen din. Oppdater etter behov.
#### 2.1.5. `patches/`
Denne mappen inneholder oppdateringer som brukes i boken, samt eldre 
oppdateringer for historiske formål, i tilfelle noen trenger de eldre 
oppdateringene, og for studienes skyld. Oppdater etter behov og hold deg 
oppdatert på nyere versjoner, men gamle versjoner må også beholdes.
#### 2.1.6. `stylesheets/`
Denne mappen inneholder Docbook XML XSLT stilarkene som trengs for å generere 
HTML fra XML kilden. Den inneholder også CSS filene som trengs for å gjøre boken 
penere. Trenger svært sjelden oppdatering.
#### 2.1.7. `template/`
Denne mappen inneholder maler som de fleste sidene i denne boken er basert på, 
hovedsakelig pakker. Den har dokumentasjon som kan hjelpe deg med å finne ut hva 
du vil og ikke vil. Den må kanskje oppdateres hvis standardene endres.
#### 2.1.8. `.gitattributes`
Denne filen er en standard git fil som gir attributter til samsvarende filer. 
Trenger sjelden å oppdateres.
#### 2.1.9. `.gitignore`
Denne filen er en standard git fil som ignorerer samsvarende filer fra å komme 
inn i git historikken og treet. For eksempel, `conditional.ent` og `version.ent`
generert av `git-version.sh` ignoreres, men kan finnes lokalt hvis du gjengir 
boken. Trenger svært sjelden å oppdateres.
#### 2.1.10. `INSTALL.md`
Denne filen beskriver hvilke pakker du trenger for å kunne gjengi boken selv. 
Trenger sjelden å oppdateres.
#### 2.1.11. `Makefile`
Denne filen er Makefile filen som brukes av **make** for å kunne gjengi boken. 
Trenger sjelden å oppdateres.
#### 2.1.12. `expand_date`
Denne filen er et Pythonskript som utvider datovariabelen i XML filer, 
selv om denne oppførselen har falt i unåde i SLFS, men fortsatt er sterk i 
BLFS. Trenger sjelden å oppdateres.
#### 2.1.13. `general.ent`
Denne filen er en XML entitetsfil som inneholder viktige variabler som brukes av 
bokens XML, og inkluderer også forskjellige entitetsfiler. Denne filen må 
oppdateres ved hver stabile utgivelse.
#### 2.1.14. `git-version.sh`
Denne filen er et skallskript som genererer versjonen og revisjonen boken skal 
gjengis for, og sender ut i henhold til teksten i `conditional.ent` og
`version.ent`. Trenger sjelden å oppdateres.
#### 2.1.15. `gnome.ent`
Denne filen er en XML entitetsfil som inneholder GNOME spesifikke enheter som 
brukes av et lite utvalg XML filer. Trenger sjelden å oppdateres.
#### 2.1.16. `obfuscate.sh`
Denne filen er et skallskript som tilslører e-postadresser i XML og HTML filer. 
Trenger sjelden å oppdateres.
#### 2.1.17. `packages.ent`
Denne filen er en XML enhetsfil som inneholder versjonsvariabler. Enkelte 
versjonsvariabler brukes av visse pakker, men vanligvis vil det bare være én 
variabel som brukes av en gitt pakke. For eksempel, &hyprutils-version;
brukes av hyprutils. Disse variablene bestemmer pakkens versjon. 
Hver gang en pakke trenger en oppdatering, må denne filen redigeres.
#### 2.1.18. `tidy.conf`
Denne filen er en konfigurasjonsfil som brukes av **tidy**. Trenger sjelden å 
bli oppdatert.
#### 2.1.19. `xent.ent`
Denne filen er en XML enhetsfil som inneholder innhold som gjentas gjennom hele 
boken. Oppdater eller legg til etter behov.

***

### 2.2. Bokfiler og mapper
Nå som de interne detaljene er dekket, er det på tide å dekke filene som har en 
sterkere innvirkning på det endelige gjengitte produktet. Her er følgende filer 
og mapper i roten av kildekoden:

- `appendices/`
- `binary/`
- `book/`
- `emu/`
- `gaming/`
- `general/`
- `graph/`
- `introduction/`
- `svr4/`
- `wm/`
- `changelog.xml` (lenke til `introduction/welcome/changelog.xml`)
- `index.xml`

Noen pakker i mappene må kanskje oppdateres hver gang en versjon oppdateres. I 
motsetning til BLFS bruker ikke SLFS md5sums, SBU-er eller størrelse. Den bruker 
imidlertid lenker og pakkeversjoner. Lenkene må være korrekte, i likhet med 
instruksjonene.

#### 2.2.1. `appendices/`
Denne mappen inneholder XML filer som gjengis på slutten av boken. Trenger 
sjelden å oppdateres.
#### 2.2.2. `binary/`
Denne mappen inneholder XML filer som er gjengitt for den binære støttedelen. 
Inneholder pakker.
#### 2.2.3. `book/`
Denne mappen inneholder XML filer som er gjengitt i begynnelsen av boken. 
Trenger sjelden å oppdateres.
#### 2.2.4. `emu/`
Denne mappen inneholder XML filer gjengitt for Emulators delen. Inneholder 
pakker.
#### 2.2.5. `gaming/`
Denne mappen inneholder XML filer gjengitt for delen om generell 
spillprogramvare. Inneholder pakker.
#### 2.2.6. `general/`
Denne mappen inneholder XML filer gjengitt for delen Generelle biblioteker og 
verktøy. Inneholder pakker.
#### 2.2.7. `graph/`
Denne mappen inneholder XML filer gjengitt for de grafiske komponentene. 
Inneholder pakker.
#### 2.2.8. `introduction/`
Denne mappen inneholder XML filer gjengitt for introduksjonsdelen av boken. 
Inneholder `welcome/changelog.xml` som trenger å oppdateres ofte. Resten av XML 
filene gjør det vanligvis ikke.
#### 2.2.9. `svr4/`
Denne mappen inneholder XML filer gjengitt for SVR4 delen av boken. 
Inneholder pakker.
#### 2.2.10. `wm/`
Denne mappen inneholder XML filer gjengitt for delene Vindusbehandlere, 
Kompositorer og Skrivebordsmiljøer. Inneholder pakker.
#### 2.2.11. `changelog.xml`
Denne symbolske lenken peker til `introduction/welcome/changelog.xml`, en XML fil 
som beskriver endringer som er gjort i boken siden forrige utgivelse. Alle endringer 
bør noteres her, og meldingen bør være lik eller nøyaktig som git commit meldingen 
som beskriver commit-en. `->` burde være `-&gt;` i XML filen. For brukeren i 
endringsloggoppføringen, ville det bli satt pris på om den samsvarte med GitHub 
brukernavnet ditt. Hvis du er en BLFS/LFS redigerer, kan du også bruke brukernavnet 
du bruker for LFS/BLFS. Endringer som ikke skal ha en endringsloggoppføring er enkle 
skrivefeil, grammatikkendringer, retting av gjengivelsesfeil, ordlyd osv. (små endringer) 
og interne endringer (ikke medregnet endringer i `packages.ent`, disse teller som 
oppdateringer som må ha en endringsloggoppføring).
#### 2.2.12. `index.xml`
Denne filen er en XML fil som bestemmer hvilke XML hovedfiler som skal inkluderes 
for gjengivelse. Tenk på den som XML hovedfilen, eller din `int main()`, men for 
XML. Trenger sjelden å endres med mindre en ny seksjon legges til.

***

### 3. Standarder
I tillegg til å vite hvor filene er, teller også innholdet i disse filene, og 
det finnes standarder å huske på.

1. Rediger `changelog.xml` etter behov. Se [seksjon 2.2.11](#2211-changelogxml).
2. Følg [stilguide](STYLE-GUIDE.md).

## 4. Gjøre en endring

### 4.1. Forutsetninger
Først trenger du
[Git](https://linuxfromscratch.org/blfs/view/stable/general/git.html) for å 
klone, pull og push. Når du har installert det, må du 
forke dette repositoriet til GitHub kontoen din. Når du har forket det, må du 
klone forkingen:
```Bash
git clone https://github.com/<username>/slfs
```
Nå som du har klonet repoet, kan du gjøre endringer i standardgrenen
`trunk`, eller du kan lage en til:
```Bash
git checkout --track origin -b <branch_name>
```

### 4.2. Redigering
Gjør nå en redigering slik du synes passer. Hvis det ikke er en redigering av en 
intern fil, eller ikke `packages.ent` eller rette en enkel skrivefeil, lage en 
endringsloggoppføring (se [seksjon 2.2.11](#2211-changelogxml)). Når du har 
laget en, kopier teksten du lagde, formater teksten du kopierte til ren tekst 
som ikke blir rotet til i en git commit melding, og utfør deretter en 
testgjengivelse. Se om gjengivelsen ser fin ut, om den ble gjengitt. Etterpå, 
utfør en `git status` å se at du redigerte de riktige filene, ikke har laget 
noen nye som ikke burde vært laget, da `git add` disse filene.

Etterpå, gjør
```Bash
git commit -m "<kopiert_tekst>" -m "<valgfri_melding>"
```

Gjør nå:
```Bash
git push origin <branch_name>
```

## 4.3. Sende inn en pull forespørsel
Nå, over på GitHub på repoet ditt, lag en pull forespørsel som fletter seg inn i
`glfs-book:trunk`. Hvis det er en konflikt, gjenta [seksjon 4.2](#42-redigering) 
for å fikse disse konfliktene før du sender inn PR-en. Hvis alt ser bra ut, send den inn.

En redaktør kan be om endringer etter gjennomgang. Dette er greit og rutinemessig. Gjenta.
[seksjon 4.2](#42-redigering) etter behov, og GitHub vil automatisk hente inn de 
nye endringene i PR-en. Skyll og gjenta til PR-en er slått sammen.

Etter det, klapp deg selv på skulderen, siden du nå er en SLFS bidragsyter.
