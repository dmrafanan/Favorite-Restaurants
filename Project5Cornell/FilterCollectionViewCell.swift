//
//  FilterCollectionViewCell.swift
//  Project5Cornell
//
//  Created by Daniel Marco S. Rafanan on Aug/1/20.
//  Copyright © 2020 Daniel Marco S. Rafanan. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = #colorLiteral(red: 0.07366979867, green: 0.1813870668, blue: 1, alpha: 0.4666630993).withAlphaComponent(0.1)
        
        label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        setupConstraints()
    }
    
    func configure(for string:String){
        label.text = string
        contentView.sizeToFit()
    }
    
    func selectCell(){
 
        if isSelected{
            contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            contentView.backgroundColor = #colorLiteral(red: 0.07366979867, green: 0.1813870668, blue: 1, alpha: 0.4666630993).withAlphaComponent(0.1)

        }
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo:  contentView.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIButtonScrollView: UICollectionView {
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIButton.self) {
            return true
        }
        
        return super.touchesShouldCancel(in: view)
    }
}

