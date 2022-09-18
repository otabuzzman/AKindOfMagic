import ShazamKit

let audioFile = "Dateiname ohne Verzeichnis und Erweiterung"
let audioArtist = "Name des Interpreten"
let audioTitle = "Songtitel"

let audioURL = Bundle.main.url(forResource: audioFile, withExtension: "m4a")!
let audioProperties = (url: audioURL, artist: audioArtist, title: audioTitle)

let customCatalog = SHCustomCatalog()
let customCatalogURL = customCatalog.generateSignatureAndCatalog(
    fromAudio: audioProperties,
    inCatalog: "AKindOfMagic")

try? customCatalog.add(from: URL(fileURLWithPath: customCatalogURL.path))

let sheasy = SHEasy()
try? sheasy.match(in: customCatalog)

pause() // Main Thread des Playground pausieren damit Handler weiterläuft
