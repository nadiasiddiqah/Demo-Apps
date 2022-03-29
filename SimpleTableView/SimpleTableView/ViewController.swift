//
//  ViewController.swift
//  SimpleTableView
//
//  Created by Nadia Siddiqah on 2/10/22.
//

import UIKit

class ViewController: UIViewController {
    var userArr = [UserModal]()
    
    var tableView = UITableView()

    override func viewDidLoad() {
         super.viewDidLoad()
         setTableView()
         self.title = "User List"
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Amber Heard", age: "32"))
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Emma Stone", age: "30"))
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Natalie Portman", age: "37"))
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Emma Watson", age: "28"))
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Angelina Jolie", age: "43"))
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Scarlett Johansson", age: "34"))
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Jennifer Lawrence", age: "28"))
         userArr.append(UserModal(userImage: UIImage(systemName: "house")!, name: "Charlize Theron", age: "43"))
    }

    func setTableView() {
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = .systemPink
        
        self.view.addSubview(tableView)
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: "Cell")
    }
}

class CustomCell: UITableViewCell {
    lazy var backView: UIView = {
         let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 20, height: 110))
         view.backgroundColor = UIColor.white
         return view
    }()
         
    lazy var userImage: UIImageView = {
         let userImage = UIImageView(frame: CGRect(x: 4, y: 4, width: 104, height: 104))
         userImage.contentMode = .scaleAspectFill
         return userImage
    }()
         
    lazy var namelbl: UILabel = {
         let lbl = UILabel(frame: CGRect(x: 116, y: 8, width: backView.frame.width - 116, height: 30))
         lbl.textAlignment = .left
         lbl.font = UIFont.boldSystemFont(ofSize: 18)
         return lbl
    }()
         
    lazy var agelbl: UILabel = {
         let lbl = UILabel(frame: CGRect(x: 116, y: 42, width: backView.frame.width - 116, height: 30))
         lbl.textAlignment = .left
         return lbl
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          addSubview(backView)
          backView.addSubview(userImage)
          backView.addSubview(namelbl)
          backView.addSubview(agelbl)
    }
    
    override func layoutSubviews() {
          contentView.backgroundColor = UIColor.clear
          backgroundColor = UIColor.clear
          backView.layer.cornerRadius = 5
          backView.clipsToBounds = true
          userImage.layer.cornerRadius = 52
          userImage.clipsToBounds = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
     
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return userArr.count
     }
     
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomCell else {fatalError("Unabel to create cell")}
       cell.userImage.image = userArr[indexPath.row].userImage
       cell.namelbl.text = userArr[indexPath.row].name
       cell.agelbl.text = userArr[indexPath.row].age
         
       return cell
     }
     
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
     }
}

class UserModal {
   var userImage: UIImage?
   var name: String?
   var age: String?
     
   init(userImage: UIImage, name: String, age: String) {
       self.userImage = userImage
       self.name = name
       self.age = age
   }
}


