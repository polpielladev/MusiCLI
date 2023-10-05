import SwiftUI
import MusicKit

struct SongView: View {
    let song: Song
    
    var body: some View {
        ZStack {
            Color(song.artwork?.backgroundColor ?? .white)
                .ignoresSafeArea()
            VStack(spacing: 8) {
                AsyncImage(url: song.artwork?.url(width: 400, height: 400)) { image in
                    image
                        .resizable()
                        .frame(width: 400, height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    Text("Loading...")
                }
                
                Text(song.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                Text("\(song.artistName) − \(song.albumTitle ?? "")")
                    .font(.body)
                    .foregroundStyle(Color(cgColor: song.artwork?.tertiaryTextColor ?? .black))
            }
            .foregroundStyle(Color(song.artwork?.primaryTextColor ?? .black))
        }
        .frame(width: 600, height: 600)
    }
}
