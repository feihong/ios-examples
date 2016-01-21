Playlist Example
================

Demonstrates how to access the playlists on your device.

[General Media Item Property Keys](https://developer.apple.com/library/prerelease/ios/documentation/MediaPlayer/Reference/MPMediaItem_ClassReference/index.html#//apple_ref/doc/constant_group/General_Media_Item_Property_Keys)

## Getting lyrics for a song

```swift
import AVFoundation

let url = mediaItem.valuevalueForProperty(MPMediaItemPropertyAssetURL) as! NSURL
let asset = AVURLAsset(URL: url, options: nil)
let lyrics = asset.lyrics
```

## Relevant media item property keys

- MPMediaItemPropertyArtwork
- MPMediaItemPropertyTitle
- MPMediaItemPropertyArtist
- MPMediaItemPropertyAlbumTitle
- MPMediaItemPropertyGenre
- MPMediaItemPropertyPlaybackDuration
- MPMediaItemPropertyComments
- MPMediaItemPropertyLyrics
