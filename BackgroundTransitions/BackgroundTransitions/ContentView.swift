//
//  ContentView.swift
//  BackgroundTransitions
//
//  Created by Nadia Siddiqah on 11/16/21.
//

import SwiftUI

struct ContentView: View {
    var userExists = true
    var hasPersonalInfo = false

    var body: some View {
        NavigationView {
            VStack {
                if !userExists {
                    SignupView()
                } else if !hasPersonalInfo {
                    PersonalInfoView()
                } else {
                    Text("Signup complete")
                }
            }
        }
    }
}

struct SignupView: View {
    @State private var isLinkActive = false

    var body: some View {
        VStack {
            Text("SignupView")
            Button("Go to PersonalInfoView") {
                self.isLinkActive = true
            }
            .background(NavigationLink(destination: PersonalInfoView(), isActive: $isLinkActive) { EmptyView() }.hidden())
        }
    }
}

struct PersonalInfoView: View {
    @State private var isLinkActive = false

    var body: some View {
        VStack {
            Text("PersonalInfoView")
            Button("Go to MainView") {
                self.isLinkActive = true
            }
            .background(NavigationLink(destination: Text("Signup complete"), isActive: $isLinkActive) { EmptyView() }.hidden())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
