

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    
    var diningTypeLabel:UILabel!
    
    var priceLabel:UILabel!
    
    var name:UILabel!
    var size:CGFloat {
        return contentView.bounds.width
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "image")
        
        contentView.addSubview(imageView)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        name.font = UIFont.preferredFont(forTextStyle: .body).withSize(dynamicSize(40))
        name.textColor = .black
        
        diningTypeLabel = UILabel()
        diningTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(diningTypeLabel)
        diningTypeLabel.font = UIFont.preferredFont(forTextStyle: .footnote).withSize(dynamicSize(30))
        diningTypeLabel.textColor = .black
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        priceLabel.font = UIFont.preferredFont(forTextStyle: .footnote).withSize(dynamicSize(30))
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
        
        setupConstraints()

    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: dynamicSize(20)),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: dynamicSize(20)),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: dynamicSize(-20)),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: contentView.bounds.height * 0.60),
            
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: dynamicSize(16)),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: dynamicSize(16)),
            name.heightAnchor.constraint(equalToConstant: dynamicSize(35)),
            
            diningTypeLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: dynamicSize(20)),
            diningTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: dynamicSize(20)),
            diningTypeLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width/2),
            diningTypeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: contentView.bounds.height * 0.40),
            
            priceLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: dynamicSize(20)),
            priceLabel.leadingAnchor.constraint(equalTo: diningTypeLabel.trailingAnchor, constant: 0),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: dynamicSize(-20)),
            priceLabel.heightAnchor.constraint(equalTo: diningTypeLabel.heightAnchor),
            
        ])
    }
    
    func configure(for restaurant:Restaurant){
        self.name.text = restaurant.name
        self.imageView.image = UIImage(named: restaurant.imageName)
        self.diningTypeLabel.text = restaurant.category.rawValue
        switch(restaurant.price){
        case .cheap:
        self.priceLabel.text = "💲"
        case .average:
        self.priceLabel.text = "💲💲"
        case .expensive:
        self.priceLabel.text = "💲💲💲"
        }
         //restaurant.price.rawValue
    }
    
    func dynamicSize(_ size: CGFloat) -> CGFloat {
        let width = contentView.bounds.width
        let calculatedSize = width / 375 * size
        return calculatedSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

