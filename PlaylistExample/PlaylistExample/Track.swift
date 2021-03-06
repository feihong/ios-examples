import MediaPlayer

protocol Track {
    var title: String {get}
    var artist: String {get}
    var album: String {get}
    var genre: String {get}
    var duration: NSTimeInterval {get}
    var comments: String {get}
    var lyrics: String {get}
    var artwork: MPMediaItemArtwork? {get}
}

struct TrackStub : Track {
    var title: String = "Track"
    var artist: String = "Artist"
    var album: String = ""
    var genre: String = ""
    var duration: NSTimeInterval = 0
    var comments: String = ""
    var lyrics: String = ""
    var artwork: MPMediaItemArtwork? = nil
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

class MediaItemWrapper {
    var item: MPMediaItem
    
    init(item: MPMediaItem) {
        self.item = item
    }
    
    func getString(property: String) -> String {
        let result = item.valueForProperty(property) ?? ""
        return result as! String
    }
}

class MediaTrack : MediaItemWrapper, Track {
//    var id: String {
//        return "\(item.valueForProperty(MPMediaItemPropertyPersistentID)!)"
//    }
    var title: String {
        return getString(MPMediaItemPropertyTitle)
    }
    var artist: String {
        return getString(MPMediaItemPropertyArtist)
    }
    var album: String {
        return getString(MPMediaItemPropertyAlbumTitle)
    }
    var genre: String {
        return getString(MPMediaItemPropertyGenre)
    }
    var duration: NSTimeInterval {
        return item.valueForProperty(MPMediaItemPropertyPlaybackDuration) as! NSTimeInterval
    }
    var comments: String {
        return getString(MPMediaItemPropertyComments)
    }
    var lyrics: String {
        return getString(MPMediaItemPropertyLyrics)
    }
    var artwork: MPMediaItemArtwork? {
        return item.valueForProperty(MPMediaItemPropertyArtwork) as! MPMediaItemArtwork?
    }
}