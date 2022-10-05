# AKindOfMagic

Das Repository ergänzt den Hintergrundartikel _A Kind of Magic_ im Apple-Magazin [Mac & i Heft 5/2022, S. 138](https://www.heise.de/select/mac-and-i/2022/5/2209113283329077435). Es enthält das Code-Schnipsel aus dem Artikel, mit dem sich Songs in einem selbst erstellten Katalog finden lassen. Der Artikel beschreibt außerdem die Katalogerstellung mit ShazamKit CLI, einem Tool für die Kommandozeile, das Apple für macOS 13 angekündigt hat.

Da macOS 13 noch nicht raus ist, gibt's für Hacker on a hurry zusätzlichen Code zur Katalogerstellung mit der ShazamKit API.

Das Anwendungsbeispiel für Swift Playgrounds 4 (SP4) unter iPadOS 15 erzeugt einen Katalog mit einem (1) Song und startet anschließend die Musikerkennung. Sobald es den Song _hört_, erscheinen die Metadaten dazu auf der Console des Playgrounds.

### Und so geht's:
1. SP4 installieren und neuen Playground öffnen.
2. Eine neue Page mit Namen _AKindOfMagic_ anlegen.
3. Den Inhalt von `AKindOfMagic.swift` aus dem Repository in die Page _AKindOfMagic_ kopieren (beispielsweise per copy&paste).
4. Im Ordner _UserModule_ die Dateien `SHEasy.swift` und `SHCustomCatalog.swift` anlegen.
6. Die Inhalte der beiden gleichnamigen Dateien aus dem Repository nach _UserModule_ kopieren (copy&paste).

7. Audiodatei (.m4a) eines Songs als Ressource hinzufügen.
8. Dateinamen und Metdaten des gewählten Songs am Anfang der Page _AKindOfMagic_ aktualisieren.

9. Playground starten und den Song in der Nähe abspielen (beispielsweise auf dem iPhone).

10. Nach wenigen Sekunden erscheinen die Metadaten auf der Console des Playgrounds.

### Wie die Audiodatei auf's iPad kommt

Zur Auswahl von Ressourcen verwendet SP4 die Dateien-App, d.h. die Audiodatei muss vorher irgendwie ins Dateisystem des iPad gelangen. Dazu einfach die betreffende Datei aus der iTunes Mediathek (oder einer anderen Quelle) in die iCloud kopieren. Anschließend in SP4 in der Ressourcenauswahl dorthin navigieren und die Audiodatei auswählen.

### Links
- [Apple ShazamKit Framework](https://developer.apple.com/documentation/shazamkit)
- [ShazamKit Tutorial for iOS](https://www.raywenderlich.com/26236685-shazamkit-tutorial-for-ios-getting-started)
