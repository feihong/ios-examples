import UIKit
import MediaPlayer
import AVFoundation


let songTitle = "动物"
//let songTitle = "MAMA"


let applicationPlayer = MPMusicPlayerController.applicationMusicPlayer()


class ViewController: UIViewController, AVAudioPlayerDelegate {
    var song: MPMediaItem? = nil
    var player: AVAudioPlayer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    
        song = getSong(songTitle)
        printSong()
        
        applicationPlayer.beginGeneratingPlaybackNotifications()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "playbackStateChanged:",
            name: MPMusicPlayerControllerPlaybackStateDidChangeNotification,
            object: applicationPlayer)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "nowPlayingItemChanged:",
            name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification,
            object: applicationPlayer)
    }
    
    @IBAction func printSong() {
        if let song = song {
            print("\(song.title!) - \(song.lastPlayedDate!)")
        }
    }
    
    @IBAction func playUsingAVAudioPlayer() {
        guard let item = song else {return}
//        print("Asset URL: \(item.assetURL!)")
        playMediaItem(item)
    }
    
    @IBAction func playUsingApplicationPlayer() {
        guard let item = song else {return}
        applicationPlayer.stop()
        applicationPlayer.setQueueWithItemCollection(MPMediaItemCollection(items: [item]))
        applicationPlayer.prepareToPlay()
        applicationPlayer.play()
    }
    
    func playMediaItem(item: MPMediaItem) {
        guard let p = try? AVAudioPlayer(contentsOfURL: item.assetURL!) else {return}
        self.player = p
        p.prepareToPlay()
        p.delegate = self
        p.play()
    }
    
    func playMediaItemWithTitle(songTitle: String) {
        guard let item = getSong(songTitle) else {return}
        playMediaItem(item)
    }
    
    func playbackStateChanged(notification: NSNotification) {
        print("\(NSDate()): Playback state changed to \(applicationPlayer.playbackState.rawValue)")
    }
    
    func nowPlayingItemChanged(notification: NSNotification) {
        print("\(NSDate()): Now playing item changed to \(applicationPlayer.nowPlayingItem)")
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("\(NSDate()): Audio finished playing, successful: \(flag)")
        playMediaItemWithTitle("Sweet Home Chicago")
    }
}

func getSong(title: String) -> MPMediaItem? {
    let query = MPMediaQuery.songsQuery()
    let predicate = MPMediaPropertyPredicate(
        value:title,
        forProperty:MPMediaItemPropertyTitle,
        comparisonType:.EqualTo)
    query.addFilterPredicate(predicate)
    guard let collections = query.collections else {return nil}
    if collections.count < 1 {
        print("No results found for query")
        return nil
    }
    for song in collections[0].items {
        return song
    }
    return nil
}

