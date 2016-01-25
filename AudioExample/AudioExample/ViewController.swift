import UIKit
import MediaPlayer
import AVFoundation


let songTitle = "动物"

let applicationPlayer = MPMusicPlayerController.applicationMusicPlayer()


class ViewController: UIViewController, AVAudioPlayerDelegate {
    var song: MPMediaItem? = nil
    var player: AVAudioPlayer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    
        song = getSong(songTitle)
        printSong()
    }
    
    @IBAction func printSong() {
        if let song = song {
            print("\(song.title!) - \(song.lastPlayedDate!)")
        }
    }
    
    @IBAction func playUsingAVAudioPlayer(sender: UIButton) {
        guard let item = song else {return}
        print("Asset URL: \(item.assetURL!)")
        guard let p = try? AVAudioPlayer(contentsOfURL: item.assetURL!) else {return}
        self.player = p
        p.prepareToPlay()
        p.delegate = self
        p.play()
    }
    
    @IBAction func playUsingApplicationPlayer(sender: UIButton) {
        guard let item = song else {return}
        applicationPlayer.stop()
        applicationPlayer.setQueueWithItemCollection(MPMediaItemCollection(items: [item]))
        applicationPlayer.prepareToPlay()
        applicationPlayer.play()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio finished playing, successful: \(flag)")
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

