//
//  BackgroundNavigationStackOverflowApp.swift
//  BackgroundNavigationStackOverflow
//
//  Created by Nadia Siddiqah on 11/16/21.
//

import SwiftUI

@main
struct BackgroundNavigationStackOverflowApp: App {
    var body: some Scene {
        WindowGroup {
            BaseView()
        }
    }
}

struct BaseView: View {

    var body: some View {
        NavigationView {
            TitleView()
        }
    }
}
