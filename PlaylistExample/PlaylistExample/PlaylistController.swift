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
    var playlistId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateSongs()
    }

    func populateSongs() {
        // You have to convert back to NSNumber in order to search by playlist ID.
        let playlistNumber = NSNumber(unsignedLongLong: UInt64(playlistId)!)

        let query = MPMediaQuery.playlistsQuery()
        let hasId = MPMediaPropertyPredicate(
            value: playlistNumber,
            forProperty: MPMediaPlaylistPropertyPersistentID,
            comparisonType: .EqualTo)
        query.addFilterPredicate(hasId)
        guard let result = query.collections else {return}
        
        let playlist = result[0]
        printSongs(playlist)
        
        songs = playlist.items.map { song in
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
