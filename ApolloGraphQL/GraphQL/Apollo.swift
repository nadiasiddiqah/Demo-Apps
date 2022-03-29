//
//  Apollo.swift
//  ApolloGraphQL (iOS)
//
//  Created by Nadia Siddiqah on 7/20/21.
//

import Foundation
import Apollo

// Has network connection
// Base service used to perform different queries on graphql

class Network {
    
    // Instance of Network called shared
    static let shared = Network()
    
    // Make sure Network class is private, unless shared is used
    private init() {
        
    }
    
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
}
