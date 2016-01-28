import UIKit
import MediaPlayer
import AVFoundation


let songTitle = "动物"
let songTitle2 = "Sweet Home Chicago"


let applicationPlayer = MPMusicPlayerController.applicationMusicPlayer()


class ViewController: UIViewController, AVAudioPlayerDelegate {
    var player: AVAudioPlayer!
    var queuePlayer: AVQueuePlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        if let song = getSong(songTitle) {
            print("\(song.title!) - \(song.lastPlayedDate!)")
        }
    }
    
    @IBAction func playUsingAVAudioPlayer() {
        guard let item = getSong(songTitle) else {return}
//        print("Asset URL: \(item.assetURL!)")
        playMediaItem(item)
    }
    
    @IBAction func playUsingQueuePlayer() {
        let items: [AVPlayerItem] = [songTitle, songTitle2].map { title in
            let item = getSong(title)!
            return AVPlayerItem(URL: item.assetURL!)
        }
        queuePlayer = AVQueuePlayer(items: items)
        queuePlayer.actionAtItemEnd = .Advance
        queuePlayer.play()
    }
    
    @IBAction func playUsingApplicationPlayer() {
        guard let item = getSong(songTitle) else {return}
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
        // Will not work if app is in the background.
        playMediaItemWithTitle(songTitle2)
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

