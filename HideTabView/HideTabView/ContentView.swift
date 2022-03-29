//
//  ContentView.swift
//  HideTabView
//
//  Created by Nadia Siddiqah on 2/16/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var notificationsViewModel = NotificationsViewModel()
    @State var updateNotificationScreen = false
    @State var badgeUpdater: BadgeUpdater?
    
    var body: some View {
        TabView {
            Text("First Screen")
                .tabItem {
                    Image(systemName: "house")
                }
            
            NavigationView {
                VStack {
                    Text("Click on Bell Above to update Notifications")
                    
                    NavigationLink(
                        destination:
                            NotificationsView(),
                        isActive: $updateNotificationScreen
                    ) { EmptyView() }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            updateNotificationScreen = true
                        } label: {
                            Image(systemName: "bell")
                        }
                    }
                }
            }
            .environmentObject(notificationsViewModel)
            .tabItem {
                Image(systemName: "star")
            }
        }
        .onChange(of: notificationsViewModel.fetchNotifications(), perform: { value in
            badgeUpdater = BadgeUpdater(badgeNumber: value, badgeIndex: 1)
            if let badgeUpdater = badgeUpdater {
                badgeUpdater.onViewAppear()
            }
        })
        .onAppear {
            badgeUpdater = BadgeUpdater(badgeNumber: notificationsViewModel.fetchNotifications(), badgeIndex: 1)
            if let badgeUpdater = badgeUpdater {
                badgeUpdater.onViewAppear()
            }
        }
    }
}

struct NotificationsView: View {
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
    
    var body: some View {
        VStack {
            Stepper("No of notifications: \(notificationsViewModel.noOfNotifications)",
                    value: $notificationsViewModel.noOfNotifications)
        }
        .padding()
    }
}

class NotificationsViewModel: ObservableObject {
    @Published var noOfNotifications = 5
    
    func fetchNotifications() -> Int {
        return noOfNotifications
    }
}

final class BadgeUpdater {
    var badgeNumber: Int { ///update on change of badge value
        didSet {
            self.tabViewController?.viewControllers?[badgeIndex].tabBarItem.badgeValue = "\(self.badgeNumber)"
        }
    }
    var badgeIndex: Int { ///update on change of index
        didSet {
            self.tabViewController?.viewControllers?[badgeIndex].tabBarItem.badgeValue = "\(self.badgeNumber)"
        }
    }

    weak var tabViewController: UITabBarController?
    var observer: NSKeyValueObservation?
    init(badgeNumber: Int, badgeIndex: Int) {
        self.badgeNumber = badgeNumber
        self.badgeIndex = badgeIndex
    }

    func onViewAppear() {
        guard self.badgeNumber != 0 else { return }
        if let rootTabVC =  UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController?.children.first as? UITabBarController { //get your tab controller from window
            self.tabViewController = rootTabVC
            self.tabViewController?.viewControllers?[badgeIndex].tabBarItem.badgeValue = "\(self.badgeNumber)"
            self.observer = self.tabViewController?.viewControllers?[badgeIndex].observe(\.tabBarItem, options: .new, changeHandler: { [weak self] (vc, valueWrapper) in
                guard let self = self else { return }
                if (self.badgeNumber != 0) && valueWrapper.newValue??.badgeValue == nil {
                    //force block tab badgeNumber reset
                    vc.tabBarItem.badgeValue = "\(self.badgeNumber)"
                } else {
                    vc.tabBarItem.badgeValue = nil
                }
            })
        }
    }
}
