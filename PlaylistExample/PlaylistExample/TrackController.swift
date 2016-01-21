import UIKit

class TrackController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    
    var track: Track = TrackStub(title: "", artist: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = track.title
        titleLabel.text = track.title
        artistLabel.text = track.artist
    }
}
