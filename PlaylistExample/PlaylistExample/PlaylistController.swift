import UIKit
import MediaPlayer


// Displays the tracks within a Playlist.
class PlaylistController: UITableViewController {
    var tracks: [Track] = [
        TrackStub(title: "Break Free", artist: "Shanaynay"),
        TrackStub(title: "Sloths Rule the World", artist: "Mr Bumtastic"),
        TrackStub(title: "Starkiller Beams Destroy the Republic", artist: "Lord Snokes"),
    ]
    var playlist: PlaylistBase = PlaylistStub(id: "", name: "", count: 0) {
        didSet {
            navigationItem.title = playlist.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()        
        populateTracks()
    }

    func populateTracks() {
        // You have to convert back to NSNumber in order to search by playlist ID.
        let playlistNumber = NSNumber(unsignedLongLong: UInt64(playlist.id)!)

        let query = MPMediaQuery.playlistsQuery()
        let hasId = MPMediaPropertyPredicate(
            value: playlistNumber,
            forProperty: MPMediaPlaylistPropertyPersistentID,
            comparisonType: .EqualTo)
        query.addFilterPredicate(hasId)
        guard let result = query.collections else {return}
        
        if result.count == 0 {
            let ac = UIAlertController(
                title: "Error",
                message: "No playlist with ID \(playlist.id) was found (\(playlist.name))",
                preferredStyle: UIAlertControllerStyle.Alert)
            ac.addAction(
                UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
            return
        }
        
        let mpPlaylist = result[0]
        printSongs(mpPlaylist)
        
        tracks = mpPlaylist.items.map { item in
            return MediaTrack(item: item)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "TrackTableViewCell", forIndexPath: indexPath)
        
        let track = tracks[indexPath.row]
        cell.textLabel?.text = track.title
        cell.detailTextLabel?.text = track.artist
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTrack" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let track = tracks[row]
                let vc = segue.destinationViewController as! TrackController
                vc.track = track
            }
        }
    }
}

func printSongs(playlist: MPMediaItemCollection) {
    for song in playlist.items {
        let title = (song.valueForProperty(MPMediaItemPropertyTitle) ?? "N/A") as! String
        let artist = (song.valueForProperty(MPMediaItemPropertyArtist) ?? "N/A") as! String
        print("\(title) | \(artist)")
    }
}
