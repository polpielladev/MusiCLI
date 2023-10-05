import ArgumentParser
import MusicKit
import Spinner

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
            print("Title: " + song.title)
            print("Artist: " + song.artistName)
            print("Album: " + song.albumTitle!)
            print("Genres: " + song.genreNames.joined(separator: ", "))
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
