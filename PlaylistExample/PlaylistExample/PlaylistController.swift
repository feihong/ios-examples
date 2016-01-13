import UIKit
import MediaPlayer


struct Song {
    var title: String
    var artist: String
}


class PlaylistController: UITableViewController {
    var songs: [Song] = [
        Song(title: "Break Free", artist: "Shanaynay"),
        Song(title: "Sloths Rule the World", artist: "Mr Bumtastic"),
        Song(title: "Starkiller Beams Destroy the Republic", artist: "Lord Snokes"),
    ]
    var playlist = Playlist(id: "", name: "", count: 0) {
        didSet {
            navigationItem.title = playlist.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()        
        populateSongs()
    }

    func populateSongs() {
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
        
        songs = mpPlaylist.items.map { song in
            return Song(
                title: song.valueForProperty(MPMediaItemPropertyTitle) as! String,
                artist: song.valueForProperty(MPMediaItemPropertyArtist) as! String)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .Value2, reuseIdentifier: "SongCell")
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "SongTableViewCell", forIndexPath: indexPath)
        
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        return cell
    }

}

func printSongs(playlist: MPMediaItemCollection) {
    for song in playlist.items {
        let title = song.valueForProperty(MPMediaItemPropertyTitle)!
        let artist = song.valueForProperty(MPMediaItemPropertyArtist)!
        print("\(title) | \(artist)")
    }
}
