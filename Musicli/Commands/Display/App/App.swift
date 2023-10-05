import AppKit
import MusicKit

@MainActor
class App {
    let song: Song
    let delegate: AppDelegate
    
    init(song: Song) {
        self.song = song
        self.delegate = AppDelegate(song: song)
    }
    
    func run() {
        let app = NSApplication.shared
        app.delegate = delegate
        app.setActivationPolicy(.regular)
        app.activate(ignoringOtherApps: true)
        app.run()
    }
}
