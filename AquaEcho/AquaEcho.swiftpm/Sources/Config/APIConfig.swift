import Foundation

struct APIConfig {
    static let baseURL = "https://api.aquaecho.com/v1"
    static let apiVersion = "1.0.0"
    
    struct Endpoints {
        static let auth = "/auth"
        static let profile = "/profile"
        static let sessions = "/sessions"
        static let analytics = "/analytics"
        static let sync = "/sync"
    }
    
    struct Headers {
        static let contentType = "application/json"
        static let accept = "application/json"
        static let apiKey = "X-API-Key"
        static let authorization = "Authorization"
    }
    
    struct TimeoutIntervals {
        static let request: TimeInterval = 30
        static let resource: TimeInterval = 300
    }
    
    struct CachePolicy {
        static let `default` = URLRequest.CachePolicy.useProtocolCachePolicy
        static let offline = URLRequest.CachePolicy.returnCacheDataDontLoad
    }
}
