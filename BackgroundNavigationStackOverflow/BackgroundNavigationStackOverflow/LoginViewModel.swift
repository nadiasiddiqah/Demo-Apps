//
//  LoginViewModel.swift
//  BackgroundNavigationStackOverflow
//
//  Created by Nadia Siddiqah on 11/16/21.
//

import SwiftUI
import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    func loginRequest() {
        // Code for login API request
    }
}
