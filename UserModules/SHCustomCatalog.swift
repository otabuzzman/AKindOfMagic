import ShazamKit

extension SHCustomCatalog {
    public func generateSignatureAndCatalog(fromAudio properties: (url: URL, artist: String, title: String), inCatalog: String) -> URL {
        let audioFile = try? AVAudioFile(forReading: properties.url)

        // Die Abtastrate muss der des Songs in properties.url entsprechen
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: 48000, channels: 1)

        // Puffer für Audiodatei
        let audioPCMBuffer = AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat, frameCapacity: AVAudioFrameCount(audioFile!.length))

        // Puffer für ShazamKit
        let shazamKitPCMBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat!, frameCapacity: AVAudioFrameCount(audioFile!.length))

        // Der Konverter bereitet den Puffer mit der Audiodatei für ShazamKit vor
        let converter = AVAudioConverter(from: audioFile!.processingFormat, to: audioFormat!)

        do {
            // Audiodatei in Puffer einlesen
            try audioFile?.read(into: audioPCMBuffer!)
        } catch {
            print("Fehler beim Einlesen der Audiodatei: \(error)")
        }

        do {
            var error: NSError? = nil
            // Puffer der Audiodatei konvertieren
            try converter!.convert(to: shazamKitPCMBuffer!, error: &error, withInputFrom: {
                inNumPackets, outStatus in

                outStatus.pointee = AVAudioConverterInputStatus.haveData
                return audioPCMBuffer 
            })
        } catch {
            print("Fehler beim Konvertieren des Audiodateipuffers: \(error)")
        }

        let signatureGenerator = SHSignatureGenerator()

        do {
            // Reference Signature aus konvertierter Audiodatei erzeugen
            try signatureGenerator.append(shazamKitPCMBuffer!, at: nil)
        } catch {
            print("Fehler beim Erzeugen der Reference Signature: \(error)")
        } 

        let signature = signatureGenerator.signature()

        // Für Neugierige...
        print("signature: \(String(describing: signature))")
        print("signature duration: \(signature.duration)")

        // Eigenen Katalog erstellen
        let catalog = SHCustomCatalog()
        // Media Item erzeugen
        let item = SHMediaItem(properties: [
            .artist: properties.artist,
            .title: properties.title
            // ...
        ])

        // Reference Signature und Media Item dem eigenen Katalog hinzufügen
        try? catalog.addReferenceSignature(signature, representing: [item])

        // Dateiname für eigenen Katalog festlegen
        let catalogURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(inCatalog)
            .appendingPathExtension("shazamcatalog")

        // Vorhandene Datei gegebenenfalls löschen
        if FileManager.default.fileExists(atPath: catalogURL.path) {
            try? FileManager.default.removeItem(atPath: catalogURL.path)
        }

        do {
            try catalog.write(to: catalogURL)

            // Für Zweifler...
            print("\(catalogURL)")
        } catch {
            print("Fehler beim Schreiben der Katalogdatei: \(error)")
        }

        return catalogURL
    }
}
