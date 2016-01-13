import UIKit
import MediaPlayer

class MainController: UITableViewController {
    var playlists: [MPMediaItemCollection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustTableViewContentInsets()
        
        let query = MPMediaQuery.playlistsQuery()
        playlists = query.collections!
        printPlaylists()
    }
    
    func adjustTableViewContentInsets() {
        // Get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
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
