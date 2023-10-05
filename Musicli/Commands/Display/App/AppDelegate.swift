import AppKit
import SwiftUI
import MusicKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    let song: Song
    
    init(song: Song) {
        self.song = song
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let window = NSWindow(
            contentRect: .zero,
            styleMask: [.closable, .resizable, .titled],
            backing: .buffered,
            defer: false
        )
        window.contentViewController = NSHostingController(
            rootView: SongView(song: song)
        )
        window.makeKey()
        window.center()
        window.orderFrontRegardless()
        window.title = "🎶 \(song.title) - \(song.artistName)"
        
        self.window = window
    }
}
