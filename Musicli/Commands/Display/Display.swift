import MusicKit
import ArgumentParser

struct Display: AsyncParsableCommand {
    @Argument(help: "The song you'd like to display information for")
    var song: String
    
    func run() async throws {
        let request = MusicCatalogSearchRequest(term: song, types: [Song.self])
        guard let song = try await request.response().songs.first else {
            print("Could not find a song to play...")
            return
        }
        
        await App(song: song).run()
    }
}
