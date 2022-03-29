//
//  ResultState.swift
//  TestNewsApp (iOS)
//
//  Created by Nadia Siddiqah on 7/13/21.
//

import Foundation

// Controls what content user sees on the screen
enum ResultState {
    case loading                             // Show loading spinner
    
    case success(content: [Article])         // Return list of articles
    
    case failed(error: Error)                // Returns error
}
