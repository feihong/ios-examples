# Two different ways of playing audio

You must keep a reference to AVAudioPlayer or else the object gets destroyed immediately.

When you use the application player (MPMusicPlayerController) as opposed to the system player, the last played date is still updated. When you use an AVAudioPlayer, the last played date is untouched.

When Background Mode is off, neither player continues playing when the app is backgrounded. However, AVAudioPlayer automatically resumes playing when the app is foregrounded, while the application player does not.

When Background Mode is on and set to audio, the AVAudioPlayer is still paused when the app is backgrounded (and still resumes when the app is foregrounded). The AVAudioPlayer keeps playing when the app is backgrounded, but its playback state and now item notifictions are queued up and delivered only after the app is foregrounded.
