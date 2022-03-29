//
//  Champion.swift
//  MVVM_Autolayout
//
//  Created by Nadia Siddiqah on 1/18/22.
//

import Foundation

struct Champion {
  enum Kind {
    case assassin
    case fighter
    case mage
    case marksmen
    case support
    case tank
    
    var description: String {
      switch self {
      case .assassin: return "Assassin"
      case .fighter: return "Fighter"
      case .mage: return "Mage"
      case .marksmen: return "Marksmen"
      case .support: return "Support"
      case .tank: return "Tank"
      }
    }
  }
  
  let name: String
  let fileName: String
  let type: Kind
  let description: String
}
