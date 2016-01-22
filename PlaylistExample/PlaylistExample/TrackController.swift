import UIKit
import MediaPlayer

class TrackController: UIViewController {
    @IBOutlet var artwork: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albumLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var lyricsLabel: UILabel!
    
    var track: Track = TrackStub(title: "", artist: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = track.title
        artwork.image = getImage(track.artwork)
        titleLabel.text = track.title
        artistLabel.text = track.artist
        albumLabel.text = track.album
        genreLabel.text = track.genre
        durationLabel.text = getDurationString(track.duration)
        commentsLabel.text = track.comments
        lyricsLabel.text = track.lyrics
    }
}

func getDurationString(interval: NSTimeInterval) -> String {
    let ti = NSInteger(interval)
    let seconds = ti % 60
    let minutes = (ti / 60)
    return NSString(format: "%.2d:%0.2d", minutes, seconds) as String
}

func getImage(artwork: MPMediaItemArtwork?) -> UIImage? {
    if let artwork = artwork {
        let size = CGSize(width: 150, height: 150)
        return artwork.imageWithSize(size)
    }
    return nil
}