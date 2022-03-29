//
//  ContentView.swift
//  SwiftUIButtons
//
//  Created by Nadia Siddiqah on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SomeButtons()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SomeButtons: View {
    
    @State var showEditScreen = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                showEditScreen = true
            }) {
                Text("Edit Screen")
            }
            
            NavigationLink(
                destination: EditScreen(),
                isActive: $showEditScreen) { EmptyView() }
        }
    }
}

struct EditScreen: View {
    @State var showImageView = false
    @State var showPositionView = false
    @State var showSkillsView = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Group {
                    Button(action: {
                        showImageView = true
                    }) {
                        Text("ImageView")
                    }
                    
                    NavigationLink(
                        destination: ImageView(),
                        isActive: $showImageView) { EmptyView() }
                }
                
                Group {
                    Button(action: {
                        showPositionView = true
                    }) {
                        Text("PositionView")
                    }
                    
                    NavigationLink(
                        destination: PositionView(),
                        isActive: $showPositionView) { EmptyView() }
                    
                }
                
                Group {
                    Button(action: {
                        showSkillsView = true
                    }) {
                        Text("SkillsView")
                    }
                    
                    NavigationLink(
                        destination: SkillsView(),
                        isActive: $showSkillsView) { EmptyView() }
                }
            }
        }
    }
}

struct ImageView: View {
    var body: some View {
        Text("ImageView is tapped")
    }
}

struct PositionView: View {
    var body: some View {
        Text("PositionView is tapped")
    }
}

struct SkillsView: View {
    var body: some View {
        Text("SkillsView is tapped")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
