import SwiftUI
import GoogleSignIn

struct ContentView: View {
    
    @EnvironmentObject var googleDelegate: GoogleDelegate
    
    var body: some View {
        if googleDelegate.signedIn {
            VStack {
                Text(GIDSignIn.sharedInstance().currentUser.profile.name)
                Text(GIDSignIn.sharedInstance().currentUser.profile.email)
                Button(action: {
                    GIDSignIn.sharedInstance().signOut()
                    googleDelegate.signedIn = false
                }) {
                    Text("Sign Out")
                }
            }
        } else {
            GoodleSignInButton()
                .navigationTitle("Sign In")
        }
    }
    
}

struct GoodleSignInButton: View {
    
    var body: some View {
        Button(action: {
            GIDSignIn.sharedInstance()?.signIn()
        }) {
        Text("Sign in with Google")
            .padding()
            .background(Color.red)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.red, lineWidth: 1))
        }
    }
    
}

struct GoodleSignOutButton: View {
    
    var body: some View {
        Button(action: {
            GIDSignIn.sharedInstance()?.signIn()
        }) {
        Text("Sign in with Google")
            .padding()
            .background(Color.red)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.red, lineWidth: 1))
        }
    }
    
}
