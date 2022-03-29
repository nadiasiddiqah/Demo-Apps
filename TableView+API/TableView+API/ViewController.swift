//
//  ViewController.swift
//  TableView+API
//
//  Created by Nadia Siddiqah on 2/11/22.
//

import Foundation
import UIKit
import AlamofireImage

final class AmiiboAPI {
    
    // make one shared instance derived from AmiiboAPI used throughout app instead of creating multiple instances in different places
    static let shared = AmiiboAPI()
    
    func fetchAmiiboList(completion: @escaping ([Amiibo]) -> ()) {
        let urlString = "http://www.amiiboapi.com/api/amiibo"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            guard let amiiboList = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("can't decode json")
                return
            }
            
            completion(amiiboList.amiibo)
        }
        task.resume()
    }
}

struct AmiiboList: Codable {
    let amiibo: [Amiibo]
    
}

struct Amiibo: Codable {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: AmiiboRelease
    let tail: String
    let type: String
}

struct AmiiboRelease: Codable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}


class AmiiboListVC: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var amiiboList = [Amiibo]()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        safeArea = view.safeAreaLayoutGuide
        setupTableView()
        
        AmiiboAPI.shared.fetchAmiiboList { fetchAmiiboList in
            DispatchQueue.main.async {
                self.amiiboList = fetchAmiiboList
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
        // always add subview before adjusting constraints
        view.addSubview(tableView)
        
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            .isActive = true
        
    }
}

extension AmiiboListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid",
                                                 for: indexPath) as! AmiiboCell
        let amiibo = amiiboList[indexPath.row]
        
        cell.nameLabel.text = amiibo.name
        cell.gameSeriesLabel.text = amiibo.gameSeries
        
        if let url = URL(string: amiibo.image) {
            let filter = AspectScaledToFillSizeFilter(size: cell.imageIV.frame.size)
            cell.imageIV.af.setImage(withURL: url, filter: filter)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return amiiboList.count
    }
}

class AmiiboCell: UITableViewCell {
    let imageIV = UIImageView()
    let nameLabel = UILabel()
    var safeArea: UILayoutGuide!
    let gameSeriesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        safeArea = layoutMarginsGuide
        setupImageView()
        setupNameLabel()
        setupGameSeriesLabel()
    }
    
    func setupImageView() {
        addSubview(imageIV)
        
        imageIV.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            .isActive = true
        imageIV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5)
            .isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    
    func setupGameSeriesLabel() {
        addSubview(gameSeriesLabel)
        
        gameSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        gameSeriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        gameSeriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
}
