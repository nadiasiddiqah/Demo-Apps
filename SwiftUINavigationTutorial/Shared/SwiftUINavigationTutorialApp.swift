//
//  SwiftUINavigationTutorialApp.swift
//  Shared
//
//  Created by Nadia Siddiqah on 9/30/21.
//

import SwiftUI

@main
struct SwiftUINavigationTutorialApp: App {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.red]
    }
    
    
    var body: some Scene {
        WindowGroup {
            RedOneView()
        }
    }
}
