import ArgumentParser
import MusicKit
import Spinner
import ANSITerminal

struct Search: AsyncParsableCommand {
    func run() async throws {
        guard await isAppAuthorised() else { return }
        
        print("Enter the name of the song you'd like to search for...")
        guard let query = readLine() else { return }
        print("")
        
        let spinner = Spinner(.dots, "Loading results...", color: .green)
        spinner.start()
        let request = MusicCatalogSearchRequest(term: query, types: [Song.self])
        let searchResponse = try await request.response()
        spinner.stop()
        
        print("Search results for: '\(query)'")
        print("")
        
        for song in searchResponse.songs {
            print("Title: ".bold + song.title)
            print("Artist: ".bold + song.artistName)
            print("Album: ".bold + song.albumTitle!)
            print("Genres: ".bold + song.genreNames.joined(separator: ", "))
            print("")
        }
    }
    
    private func isAppAuthorised() async -> Bool {
        guard MusicAuthorization.currentStatus != .authorized else {
            return true
        }
        
        let response = await MusicAuthorization.request()
        return response == .authorized
    }
}
