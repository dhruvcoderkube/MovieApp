//
// Copyright (c) 2023 YASSIR. All rights reserved.
//

import Foundation

enum APIEndPoint{
    
    case movieListing
    case configuration
    case details(Int)
    
     var value: String {
        switch self {
       
        case .movieListing:
            return "discover/movie"
            
        case .configuration:
            return "configuration"
            
        case .details(let movieID):
            return "movie/\(movieID)"
        }
    }
}
