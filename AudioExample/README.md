# Three different ways of playing audio

You must keep a reference to AVAudioPlayer or else the object gets destroyed immediately.

When you use the application player (MPMusicPlayerController) as opposed to the system player, the last played date is still updated. When you use an AVAudioPlayer, the last played date is untouched.

When Background Mode is off, neither player continues playing when the app is backgrounded. However, AVAudioPlayer automatically resumes playing when the app is foregrounded, while the application player does not.

When Background Mode is on and set to audio, this happens:

- If no audio session is active, then the behavior of AVAudioPlayer remains the same (paused when backgrounded and resumed when foregrounded)
- If an active audio session set to Playback, then the AVAudioPlayer keeps playing when the phone is locked. It also continues to deliver notifications to its delegate.
- The application player keeps playing when the app is backgrounded, but its playback state and now item notifictions are queued up and delivered only after the app is foregrounded.

With Background Mode on, the audioPlayerDidFinishPlaying delegate callback is invoked, but within that callback you are unable to play other audio files. No exception is thrown and it doesn't crash--it simply ignores the call to AVAudioPlayer.play().

A bit later, I found out about AVQueuePlayer from [this article](http://www.raywenderlich.com/92428/background-modes-ios-swift-tutorial). It shows the usage of AVQueuePlayer, which can be used to play a series of audio files consecutively in a fashion similar to the application player. I don't believe it's possible to add more items to the queue after playback stops (when app is backgrounded), although I haven't yet tested this theory. 
