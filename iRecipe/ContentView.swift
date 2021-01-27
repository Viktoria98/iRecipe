import SwiftUI
import GoogleSignIn

struct ContentView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        if authManager.signedIn {
            VStack {
                Text(GIDSignIn.sharedInstance().currentUser.profile.name)
                Text(GIDSignIn.sharedInstance().currentUser.profile.email)
                Button(action: {
                    GIDSignIn.sharedInstance().signOut()
                    authManager.signedIn = false
                }) {
                    Text("Sign Out")
                }
            }
        } else {
            VStack {
                Spacer()
                GoodleSignInButton()
                    .navigationTitle("Sign In")
                    .offset(y: -20)
            }
        }
    }
    
}

struct GoodleSignInButton: View {
    
    var body: some View {
        Button(action: {
            GIDSignIn.sharedInstance()?.signIn()
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
