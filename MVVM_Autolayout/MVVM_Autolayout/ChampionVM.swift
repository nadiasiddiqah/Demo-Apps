//
//  ChampionVM.swift
//  MVVM_Autolayout
//
//  Created by Nadia Siddiqah on 1/18/22.
//

import Foundation
import Combine

class ChampionVM {
    @Published var model: Champion
    let bundle: Bundle
    
    init(model: Champion, bundle: Bundle = Bundle.main) {
        self.model = model
        self.bundle = bundle
    }
    
    func portraitFilePath(for champion: Champion) -> String? {
        return self.bundle.path(forResource: champion.fileName, ofType: nil)
    }
}
