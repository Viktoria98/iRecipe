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
                GeometryReader { geometry in
                    LottieView()
                        .frame(width: geometry.size.width, height: geometry.size.height/3)
                    Text("Welcome")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: geometry.size.height/3 + 50)
                        .padding()
                        .font(Font.title.weight(Font.Weight.bold))
                        .textCase(.uppercase)
                        .foregroundColor(.primaryPurple)
                    Text("Create your recipes and share them with friends")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: geometry.size.height/3 + 100)
                        .padding()
                        .foregroundColor(.gray)
                        .font(.title3)
                }
                Text("Enter via social networks")
                    .font(.caption)
                    .foregroundColor(.gray)
                GoodleSignInButton(action: authManager.googleSignIn)
                Text("or")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                FacebookSignInButton(action: {})
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
        Text(" Sign in with Google  ")
            .padding(EdgeInsets(top: 15, leading: 70, bottom: 15, trailing: 70))
            .background(Color.primaryPink)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.primaryPink, lineWidth: 1))
        }
    }
    
}

struct FacebookSignInButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
        Text("Sign in with Facebook")
            .padding(EdgeInsets(top: 15, leading: 70, bottom: 15, trailing: 70))
            .background(Color.facebookPurple)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.facebookPurple, lineWidth: 1))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
