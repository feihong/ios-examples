import UIKit
import MediaPlayer


// Displays all Playlists.
class MainController: UITableViewController {
    var playlists: [PlaylistBase] = [
        PlaylistStub(id: "1", name: "Disco Party", count: 55),
        PlaylistStub(id: "2", name: "Chill Muzak", count: 23),
        PlaylistStub(id: "3", name: "Driving", count: 146),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()        
        printPlaylists()
        populatePlaylists()
    }
    
    func populatePlaylists() {
        let query = MPMediaQuery.playlistsQuery()
        guard let result = query.collections else {return}
        
        playlists = result.map { item in
            return Playlist(item: item)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "PlaylistTableViewCell", forIndexPath: indexPath)
        
        let playlist = playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\(playlist.count)"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPlaylist" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let playlist = playlists[row]
                let vc = segue.destinationViewController as! PlaylistController
                vc.playlist = playlist
            }
        }
    }
}

func printPlaylists() {
    let query = MPMediaQuery.playlistsQuery()
    guard let result = query.collections else {return}
    print("Number of playlists: ", result.count)
    for playlist in result {
        let id = playlist.valueForProperty(MPMediaPlaylistPropertyPersistentID) as! NSNumber
        let name = playlist.valueForProperty(MPMediaPlaylistPropertyName) as! String
        print("\(id): \(name), \(playlist.count)")
    }
}
