//
//  SignupViewModel.swift
//  BackgroundNavigationStackOverflow
//
//  Created by Nadia Siddiqah on 11/16/21.
//

import SwiftUI
import Combine
import Foundation

class SignupViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoginDataValid = false

    func signupRequest() {
        // Code for signup API request
    }
}
