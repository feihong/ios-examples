import UIKit
import MediaPlayer


struct Playlist {
    var id: String
    var name: String
    var count: Int
}

class MainController: UITableViewController {
    var playlists: [Playlist] = [
        Playlist(id: "1", name: "Disco Party", count: 55),
        Playlist(id: "2", name: "Chill Muzak", count: 23),
        Playlist(id: "3", name: "Driving", count: 146),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        printPlaylists()
        populatePlaylists()
    }
    
    func populatePlaylists() {
        let query = MPMediaQuery.playlistsQuery()
        guard let result = query.collections else {return}
        
        playlists = result.map { playlist in
            return Playlist(
                id: "\(playlist.valueForProperty(MPMediaPlaylistPropertyPersistentID)!)",
                name: playlist.valueForProperty(MPMediaPlaylistPropertyName) as! String,
                count: playlist.count)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "PlaylistCell")
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
                vc.playlistId = playlist.id
            }
        }
    }
}

func printPlaylists() {
    let query = MPMediaQuery.playlistsQuery()
    guard let result = query.collections else {return}
    print("Number of playlists: ", result.count)
    for playlist in result {
        let id = playlist.valueForProperty(MPMediaPlaylistPropertyPersistentID)!
        let num = id as! NSNumber
        let idString = "\(id)"
        let name = playlist.valueForProperty(MPMediaPlaylistPropertyName) as! String
        if name == "Potluck" {
            print(id)
        }
        print("\(id): \(name), \(playlist.count)")
    }
}
