import UIKit
import AVFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        _ = try? AVAudioSession.sharedInstance().setCategory(
            AVAudioSessionCategoryPlayback, withOptions: [])
        
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        _ = try? AVAudioSession.sharedInstance().setActive(
            true, withOptions: [])
    }
}

