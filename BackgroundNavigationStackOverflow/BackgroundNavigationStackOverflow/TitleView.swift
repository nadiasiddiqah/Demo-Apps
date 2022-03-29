import SwiftUI
import Combine
import Foundation

struct TitleView: View {
    @State private var showSignup = false
    @State private var showLogin = false

    var signupViewModel = SignupViewModel()
    
    var body: some View {
        VStack(spacing: 35) {
            Text("Reelfolio Title")
            Text("Where the world's best filmmakers come together.")
            
            Button("Sign up") {
                showSignup = true
            }
            
            Button("Log in") {
                showLogin = true
            }
            
            NavigationLink(destination: SignupView(viewModel: signupViewModel),
                           isActive: $showSignup) { EmptyView() }
            
            NavigationLink(destination: LoginView(viewModel: .init()),
                           isActive: $showLogin) { EmptyView() }
        }
        .padding([.leading, .trailing], 20)
    }
}
