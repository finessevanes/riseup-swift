import SwiftUI

@main
struct RiseUpApp: App {
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
