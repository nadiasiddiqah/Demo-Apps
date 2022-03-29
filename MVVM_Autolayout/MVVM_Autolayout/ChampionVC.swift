//
//  ChampionVC.swift
//  MVVM_Autolayout
//
//  Created by Nadia Siddiqah on 1/18/22.
//

import UIKit

class ChampionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = ChampionView(viewModel: ChampionVM(model: <#Champion#>))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
