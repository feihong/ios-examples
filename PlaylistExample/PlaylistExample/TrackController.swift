import UIKit

class TrackController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albumLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var lyricsLabel: UILabel!
    
    var track: Track = TrackStub(title: "", artist: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = track.title
        titleLabel.text = track.title
        artistLabel.text = track.artist
        albumLabel.text = track.album
        genreLabel.text = track.genre
        commentsLabel.text = track.comments
        lyricsLabel.text = track.lyrics
    }
}
