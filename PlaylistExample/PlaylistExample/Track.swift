import MediaPlayer

protocol Track {
//    var id: String {get}
    var title: String {get}
    var artist: String {get}
}

struct TrackStub : Track {
//    var id: String
    var title: String
    var artist: String
}

struct MediaTrack : Track {
    var id: String {
        return "\(item.valueForProperty(MPMediaItemPropertyPersistentID)!)"
    }
    var title: String {
        return item.valueForProperty(MPMediaItemPropertyTitle) as! String
    }
    var artist: String {
        return (item.valueForProperty(MPMediaItemPropertyArtist) ?? "N/A") as! String
    }
    var item: MPMediaItem
    
    init(item: MPMediaItem) {
        self.item = item
    }
}