//
//  ChampionView.swift
//  MVVM_Autolayout
//
//  Created by Nadia Siddiqah on 1/18/22.
//

import UIKit
import Combine

class ChampionView: UIView {
    
    private var viewModel: ChampionVM
    private var cancellables = Set<AnyCancellable>()
    
    private let portraitPicture = UIImageView()
    private let name = UILabel()
    private let typeLabel = UILabel()
    private let typeValue = UILabel()
    private let champDescription = UILabel()
    private var randomChamp = UIButton()
    
    init(viewModel: ChampionVM) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        self.setup()
        self.style()
        self.setupBindings()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(self.portraitPicture)
        self.addSubview(self.name)
        self.addSubview(self.typeLabel)
        self.addSubview(self.typeValue)
        self.addSubview(self.champDescription)
        self.addSubview(self.randomChamp)
        
//        self.randomChamp.addTarget(self, action: #selector(userDidTapButton(_:)), for: .touchUpInside)
    }
//
//    @objc func userDidTapButton(_ sender: UIButton) {
//        self.viewModel.randomChamp()
//    }
    
    func style(){
        self.backgroundColor = .black
        self.portraitPicture.clipsToBounds = true
        self.portraitPicture.layer.cornerRadius = 60
        
        self.name.textColor = .systemOrange
        self.name.font = .systemFont(ofSize: 18)
        self.name.text = "Ahri"
        self.name.textAlignment = .center
        
        self.typeLabel.textColor = .systemOrange
        self.typeLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        self.typeLabel.text = "Type"
        
        self.typeValue.textColor = .systemOrange
        self.typeValue.font = .systemFont(ofSize: UIFont.systemFontSize)
        self.typeValue.text = "Mage"
        
        self.champDescription.textColor = .white
        self.champDescription.text = "Lorem ipsium hic sunt leones\net veni, vidi, vici."
        self.champDescription.numberOfLines = 0
        self.champDescription.textAlignment = .justified
        
        self.randomChamp.backgroundColor = .systemOrange
        self.randomChamp.layer.cornerRadius = 25
        self.randomChamp.setTitle("Random", for: .normal)
        self.randomChamp.setTitleColor(.black, for: .normal)
    }
    
    func setupBindings() {
        self.viewModel.$model.sink { model in
            self.name.text = model.name
            self.champDescription.text = model.description
            self.typeValue.text = model.type.description
            if let filePath = self.viewModel.portraitFilePath(for: model) {
                self.portraitPicture.image = .init(contentsOfFile: filePath)
            }
            self.updateConstraints()
        }
        .store(in: &cancellables)
    }
    
    func setupConstraints() {
        [
          portraitPicture,
          name,
          typeLabel,
          typeValue,
          champDescription,
          randomChamp
        ].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
          self.portraitPicture.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          self.portraitPicture.topAnchor.constraint(equalTo: self.readableContentGuide.topAnchor),
          self.portraitPicture.widthAnchor.constraint(equalToConstant: 120),
          self.portraitPicture.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
          self.name.topAnchor.constraint(equalTo: self.portraitPicture.bottomAnchor, constant: 20),
          self.name.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),
          self.name.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor),
          self.name.heightAnchor.constraint(equalToConstant: self.name.intrinsicContentSize.height)
        ])
        
        NSLayoutConstraint.activate([
          self.typeLabel.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 20),
          self.typeLabel.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
          self.typeValue.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 20),
          self.typeValue.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor),
          self.typeValue.heightAnchor.constraint(equalToConstant: self.typeValue.intrinsicContentSize.height)
          
        ])
        
        NSLayoutConstraint.activate([
          self.randomChamp.bottomAnchor.constraint(equalTo: self.readableContentGuide.bottomAnchor),
          self.randomChamp.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),
          self.randomChamp.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor),
          self.randomChamp.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
          self.champDescription.topAnchor.constraint(equalTo: self.typeValue.bottomAnchor, constant: 20),
          self.champDescription.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),
          self.champDescription.bottomAnchor.constraint(equalTo: self.randomChamp.topAnchor, constant: -20),
          self.champDescription.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor)
        ])
      }
      
}

extension UIView {
  func fill() {
    guard let superview = self.superview else {
      return
    }
    NSLayoutConstraint.activate([
      self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
      self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
      self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
    ])
  }
}
