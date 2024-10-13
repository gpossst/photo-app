//
//  PhotoChoice2App.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/4/24.
//

import SwiftUI
import GoogleMobileAds

@main
struct PhotoChoice2App: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
