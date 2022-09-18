import ShazamKit

public class SHEasy: NSObject {
    var session: SHSession?
    let audioEngine = AVAudioEngine()

    public func match(in catalog: SHCustomCatalog) throws {
        session = SHSession(catalog: catalog)
        session?.delegate = self// SHEasy als Delegate registrieren

        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 2048, format: nil) {
            [weak session] buffer, audioTime in

            // Katalogsuche mit Audiodaten vom Mikrofon
            session?.matchStreamingBuffer(buffer, at: audioTime)
        }

        // Mikrofonfreigabe anfordern
        AVAudioSession.sharedInstance().requestRecordPermission {
            [weak self] success in

            guard success, let self = self else { return }
            // Audio Engine starten
            try? self.audioEngine.start()
        }
    }
}

extension SHEasy: SHSessionDelegate {
    public func session(_ session: SHSession, didFind match: SHMatch) {
        print(match.mediaItems.first) // Metadaten des Treffers ausgeben
    }
}
