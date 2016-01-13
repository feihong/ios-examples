import UIKit
import MediaPlayer

class MainController: UITableViewController {
    var playlists: [MPMediaItemCollection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = MPMediaQuery.playlistsQuery()
        playlists = query.collections!
        printPlaylists()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        
        let playlist = playlists[indexPath.row]
        let name = playlist.valueForProperty(MPMediaPlaylistPropertyName) as! String
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = "\(playlist.count)"
        
        return cell
    }
}

func printPlaylists() {
    let query = MPMediaQuery.playlistsQuery()
    guard let result = query.collections else {return}
    print("Number of playlists: ", result.count)
    for playlist in result {
        let name = playlist.valueForProperty(MPMediaPlaylistPropertyName)!
        print("\(name), \(playlist.count)")
    }
}
