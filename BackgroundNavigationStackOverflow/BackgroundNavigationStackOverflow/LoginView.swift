//
//  LoginView.swift
//  BackgroundNavigationStackOverflow
//
//  Created by Nadia Siddiqah on 11/16/21.
//

import SwiftUI
import Combine
import Foundation

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Email:")
            TextField("me@me.com", text: $viewModel.email)
                .frame(maxHeight: 20)
            Divider()
            
            Text("Password:")
            SecureField("********", text: $viewModel.password)
                .frame(maxHeight: 20)
            Divider()
            
            Button("Login") {
                viewModel.loginRequest()
            }
        }
        .navigationBarTitle("Login", displayMode: .inline)
        .padding(20)
    }
}
