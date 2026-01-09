# Stilguide

<!-- TODO: This is currently a stub and could use some work. -->

## 1. Tekst
Denne delen setter noen standarder for skriving av tekst i SLFS.

### 1.1 Serielle kommaer
Bruk [serielle kommaer](https://en.wikipedia.org/wiki/Serial_comma) (emne1,
emne2, og emne3) istedenfor (emne1, emne2 og emne3).

### 1.2 Ubestemte artikler og vokaler
For å avgjøre om man skal bruke 'a' eller 'an', uttal ordet etter artikkelen. 
Hvis det starter med en vokallyd, bruk 'an'. Ellers, bruk 'a'.

Tenk på følgende setning:
> This example is part of an SLFS style guide.

Siden 'SLFS' starter med en vokallyd, nærmere bestemt /ˈɛ/, artikkelen 'an' er
foretrukket.

For et motsatt eksempel:
> The ICU package provides a universal set of Unicode libraries.

Siden 'universal' starter med en konsonantlyd, nærmere bestemt '/ˌj/', 
artikkelen 'a' er foretrukket.

## 2. Kildekode
Denne delen setter noen standarder for SLFS kildekoden.

### 2.1 Tabulatorer
Bruk mellomrom i stedet for tabulatorer i XML filene.

### 2.2 Tekstbryting
Hold tegnantallet på en gitt linje til maksimalt 80 tegn. Dette hindrer XML 
filen i å bli stygg og uvedlikeholdbar.

Det finnes situasjoner der 80 tegn er ikke mulig, f.eks. i lenker eller 
kodeblokker. I slike situasjoner er grensen fleksibel. Men hvis du kan unngå 
det, vennligst hold deg under 80 tegngrensen.

## 3. Kommandoer
Denne delen standardiserer bruken av noen vanlige kommandoer. Dette gjøres for å 
oppmuntre til konsistens og korrekthet, samtidig som det forenkler noen handlinger.

### 3.1 Install
Noen generelle regler og eksempler for bruk av `install`:
- Der det er mulig, foretrekk `install` over `cp`.
- Send alltid `-v`.
- Utelat avstand mellom flagg med mindre det er nødvendig (f.eks. ved 
  installering av en fil med eksplisitt eierskap).
- Foretrekk å eksplisitt angi modusen i oktale tillatelser for den installerte 
  filen ved å bruke `-m` flagget. Vanligvis trenger kjørbare filer 755, og de 
  fleste andre filer trenger 644.
- For å installere en fil i en mappe uten å endre filnavnet, bruk
  `install -vDm755 myprogram -t /usr/bin/`. Anta alltid at foreldremappen 
  kanskje ikke eksisterer. Inkluder alltid en etterfølgende / for å gjøre 
  intensjonen om å installere i en mappe tydeligere.
- For å installere flere filer i en mappe uten å endre filnavnene deres, 
  bruk `install -vDm644 README LICENSE doc/*.{html,css,pdf} -t
  /usr/share/package-0.0.0/doc/`.
- For å installere en fil i en mappe og endre filnavnet, bruk `install
  -vDm755 myprogram /usr/bin/program`.
- For å installere en mappe, bruk `install -vdm755 /path/to/directory`.
- For å installere en fil med eksplisitt eierskap, bruk `install -vDm644 -o someuser
  -g somegroup myfile -t /opt/package/`.
- For å installere en tom fil, bruk `install -vDm644 /dev/null
  /usr/share/myemptyfile`.
- For å installere en fil fra en heredoc, bruk `install` sånn:
```
install -vDm644 /dev/stdin /etc/package/config << EOF
# Begin configuration for package
some_option = true
# End configuration for package
EOF
```

<!-- TODO: -->
<!-- Other commands we may want to consider: -->
<!-- - `patch` -->
<!-- - `sed` -->
