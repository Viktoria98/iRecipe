import Foundation
import Firebase
import GoogleSignIn

class GoogleDelegate: NSObject, GIDSignInDelegate, ObservableObject {
    
    @Published var signedIn = false
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        signedIn = true
        
        //TODO: save tokens
        guard let authentication = user.authentication else { return }
        _ = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        signedIn = false
    }
    
}
