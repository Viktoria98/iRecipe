import Foundation

class KeyChainManager {

    func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data] as [String: Any]

        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne ] as [String: Any]

        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            guard let dataType = (dataTypeRef as? Data) else {
                return nil
            }
            return dataType
        } else {
            return nil
        }
    }

    func delete(key: String) -> Bool {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ] as [String: Any]

        let status: OSStatus = SecItemDelete(query as CFDictionary)
        return status == noErr
    }

    func clearAll() -> Bool {
        let query = [
            kSecClass as String: kSecClassGenericPassword
        ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        return status == noErr
    }

}
