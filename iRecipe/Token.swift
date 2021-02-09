import Foundation

enum TokenType: String {
    case accessToken
    case idToken
}

class Token: Codable {

    var token: String

    init(token: String) {
        self.token = token
    }

    class func loadToken(for key: TokenType) -> Token? {
        guard let tokenObj = KeyChainManager().load(key: key.rawValue) else { return nil }
        do {
            let token = try JSONDecoder().decode(Token.self, from: tokenObj)
            return token
        } catch let error {
            print("Could not load token \(error)")
        }
        return nil
    }

    class func saveToken(token: String, for key: TokenType) {
        do {
            let tokenObj = Token(token: token)
            let encodedToken = try JSONEncoder().encode(tokenObj)
            _ = KeyChainManager().save(key: key.rawValue, data: encodedToken)
        } catch let error {
            print("Could not save token \(error)")
        }
    }

    class func deleteAllTokens() {
        let result = KeyChainManager().clearAll()
        if !result {
            print("Could not delete tokens")
        }
    }

}
