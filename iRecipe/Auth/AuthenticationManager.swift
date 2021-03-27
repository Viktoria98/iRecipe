import Foundation
import Firebase
import GoogleSignIn

class AuthenticationManager: NSObject, GIDSignInDelegate, ObservableObject {
    
    @Published var signedIn = false
    
    override init() {
        super.init()
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func signIn() {
        guard
            let accessTokenObj = Token.loadToken(for: .accessToken),
            let idTokenObj = Token.loadToken(for: .idToken)
        else { return }
        signedIn = true
        
        let credentials = GoogleAuthProvider.credential(
            withIDToken: idTokenObj.token,
            accessToken: accessTokenObj.token
        )
        firebaseSignIn(with: credentials)
    }

    func handleUrl(url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func currentUser() -> User? {
        Auth.auth().currentUser
    }
    
    func googleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func facbookSignIn() {
        
    }
    
    func signOut() {
        firebaseSignOut()
    }
    
}

extension AuthenticationManager {
    
    private func firebaseSignIn(with credentials: AuthCredential) {
        Auth.auth().signIn(with: credentials) { authResult, error in
            if let error = error {
                print("firebaseSignIn", error)
                self.signedIn = false
            } else {
                self.signedIn = true
            }
        }
    }
    
    private func firebaseSignOut() {
        do {
            Token.deleteAllTokens()
            try Auth.auth().signOut()
            self.signedIn = false
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}

extension AuthenticationManager {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        Token.saveToken(token: authentication.idToken, for: .idToken)
        Token.saveToken(token: authentication.accessToken, for: .accessToken)
        firebaseSignIn(with: credentials)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        firebaseSignOut()
    }
    
}
