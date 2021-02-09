import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack {
            if authManager.signedIn {
                Text(authManager.currentUser()?.displayName ?? "")
                Text(authManager.currentUser()?.email ?? "")
                Button(action: {
                    authManager.signOut()
                }) {
                    Text("Sign Out")
                }
            } else {
                Spacer()
                GoodleSignInButton(action: authManager.googleSignIn)
                    .navigationTitle("Sign In")
                    .offset(y: -20)
            }
        }
    }
    
}

struct GoodleSignInButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
        Text("Sign in with Google")
            .padding(EdgeInsets(top: 15, leading: 70, bottom: 15, trailing: 70))
            .background(Color.red)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.red, lineWidth: 1))
        }
    }
    
}
