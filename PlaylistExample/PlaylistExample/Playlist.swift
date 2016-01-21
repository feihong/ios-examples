import MediaPlayer


protocol PlaylistBase {
    var id: String {get}
    var name: String {get}
    var count: Int {get}
}

struct PlaylistStub : PlaylistBase {
    var id: String
    var name: String
    var count: Int
}

struct Playlist : PlaylistBase {
    var id: String {
        return "\(item.valueForProperty(MPMediaPlaylistPropertyPersistentID)!)"
    }
    var name: String {
        return item.valueForProperty(MPMediaPlaylistPropertyName) as! String
    }
    var count: Int { return item.count }
    var item: MPMediaItemCollection
    
    init(item: MPMediaItemCollection) {
        self.item = item
    }
}