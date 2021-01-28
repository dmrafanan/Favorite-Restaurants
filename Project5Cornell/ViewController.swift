//
//  ViewController.swift
//  Project5Cornell
//
//  Created by Daniel Marco S. Rafanan on Jul/30/20.
//  Copyright © 2020 Daniel Marco S. Rafanan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var restaurantCollectionView:UICollectionView!
    var filterCollectionView:UICollectionView!
    var searchController:UISearchController!
    var restaurants:[Restaurant] = []
    var restaurantsShown:[Restaurant] = []
    var filters:[CustomStringRepresentableEnum] = []
    var isFilterSelected: [Bool] = []
    let padding:CGFloat = 8
    var isRestaurantsShownLinearLayout = false
    
    let restaurantReuseIdentifier = "restaurantReuseIdentifier"
    let linearRestaurantReuseIdentifier = "linearRestaurantReuseIdentifier"
    let filterReuseIdentifier = "filterReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurants = [.init(name: "Jolibee", category: .fastfood, price: .cheap, rating: .three, cuisine: .american, imageName: "jolibee"),
                       Restaurant(name: "McDonalds", category: .fastfood, price: .cheap, rating: .four,cuisine: .american, imageName:"mcdo"),
                       Restaurant(name: "Cabalen", category: .buffet, price: .average, rating: .four, cuisine: .filipino, imageName: "cabalen"),
                       Restaurant(name: "Kuya J", category: .casual, price: .average, rating: .three, cuisine: .filipino, imageName: "kuya j"),
                       Restaurant(name: "Lemuria Gourmet", category: .fineDine, price: .expensive, rating: .five, cuisine: .assorted, imageName: "lemuria gourmet"),
                       Restaurant(name: "Starbucks", category: .coffeeShop, price: .average, rating: .four, cuisine: .assorted, imageName: "starbucks"),
                       Restaurant(name: "Seafood Island", category: .casual, price: .expensive, rating: .four, cuisine: .assorted, imageName: "seafood island"),
                       Restaurant(name: "Samgyupsalamat", category: .samgyeopsal, price: .average, rating: .four, cuisine: .korean, imageName: "samgyupsalamat"),
                       Restaurant(name: "Oyster Boy", category: .fineDine, price: .expensive, rating: .five, cuisine: .seafood, imageName: "oyster boy"),
                       Restaurant(name: "Locavore", category: .casual, price: .average, rating: .three, cuisine: .assorted, imageName: "locavore"),
                       Restaurant(name: "Red Lantern", category: .fineDine, price: .expensive, rating: .five , cuisine: .chinese, imageName: "red lantern"),
        ]
        restaurantsShown = restaurants
        
        for category in RestaurantAttributes.Category.allCases{
            filters.append(category)
        }
        for i in RestaurantAttributes.Price.allCases{
            filters.append(i)
        }
        for i in RestaurantAttributes.Rating.allCases{
            filters.append(i)
        }
        for i in RestaurantAttributes.Cuisine.allCases{
            filters.append(i)
        }
        for _ in 0..<filters.count{
            isFilterSelected.append(false)
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "My Restaurants"
        
        let rightBarButton = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(touchRightBarButton))
        
        navigationItem.rightBarButtonItem = rightBarButton
        
        view.backgroundColor = .systemGray6
        
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        
        let layoutForRestaurantCV = UICollectionViewFlowLayout()
        layoutForRestaurantCV.minimumLineSpacing = padding
        
        layoutForRestaurantCV.minimumInteritemSpacing = padding
        layoutForRestaurantCV.scrollDirection = .vertical
        
        restaurantCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutForRestaurantCV)
        restaurantCollectionView.translatesAutoresizingMaskIntoConstraints = false
        restaurantCollectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: linearRestaurantReuseIdentifier)
        restaurantCollectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: restaurantReuseIdentifier)
        restaurantCollectionView.backgroundColor = .systemGray6
        view.addSubview(restaurantCollectionView)
        restaurantCollectionView.delegate = self
        restaurantCollectionView.dataSource = self
        
        let layoutForFilterCV = UICollectionViewFlowLayout()
        layoutForFilterCV.scrollDirection = .horizontal
        layoutForFilterCV.minimumInteritemSpacing = padding
        layoutForFilterCV.minimumLineSpacing = padding
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutForFilterCV)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.backgroundColor = .systemGray6
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.delaysContentTouches = false
        filterCollectionView.allowsMultipleSelection = true
        
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        view.addSubview(filterCollectionView)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        
        setupConstraints()
    }
    
    func setupConstraints()  {
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            restaurantCollectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: padding),
            restaurantCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            restaurantCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            restaurantCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
    func filterRestaurantsShown(){
        restaurantsShown.removeAll()
        var nothingSelected = true
        var categories:[RestaurantAttributes.Category] = []
        var prices:[RestaurantAttributes.Price] = []
        var ratings:[RestaurantAttributes.Rating] = []
        var cuisines:[RestaurantAttributes.Cuisine] = []

        for i in isFilterSelected.indices {
            if isFilterSelected[i] {
                let filter = filters[i]
                if let filter = RestaurantAttributes.Category.init(rawValue: filter.rawValue){
                    categories.append(filter)
                }else if let filter = RestaurantAttributes.Price.init(rawValue: filter.rawValue){
                    prices.append(filter)
                }else if let filter = RestaurantAttributes.Rating.init(rawValue: filter.rawValue){
                    ratings.append(filter)
                }else if let filter = RestaurantAttributes.Cuisine.init(rawValue: filter.rawValue){
                    cuisines.append(filter)
                }
                nothingSelected = false
            }
        }
        
        if nothingSelected == true {
            restaurantsShown = restaurants
        }else{
            if categories.isEmpty {
                categories.append(contentsOf: RestaurantAttributes.Category.allCases)
            }
            if prices.isEmpty{
                prices.append(contentsOf: RestaurantAttributes.Price.allCases)
            }
            if ratings.isEmpty{
                ratings.append(contentsOf: RestaurantAttributes.Rating.allCases)
            }
            if cuisines.isEmpty{
                cuisines.append(contentsOf: RestaurantAttributes.Cuisine.allCases)
            }
            for restaurant in restaurants{
                if restaurant.containsFilters(categories: categories, prices: prices, ratings: ratings, cuisines: cuisines){
                    restaurantsShown.append(restaurant)
                }
            }
        }
        
        restaurantCollectionView.reloadData()
    }
    
    @objc func touchRightBarButton(){
        isRestaurantsShownLinearLayout = !isRestaurantsShownLinearLayout
            restaurantCollectionView.reloadData()
        }
        
        func filterRestaurantsWithSearchText(searchText:String) -> [Restaurant] {
            
            let searchText = searchText.replacingOccurrences(of: " ", with: "").lowercased()
            
            if !searchText.isEmpty{
                let filteredRestaurants = restaurants.filter {
                    let restaurantAttributes = $0.attributes()
                    return restaurantAttributes.contains{
                        return $0.lowercased().replacingOccurrences(of: " ", with: "").contains(searchText)
                    }
                }
                return filteredRestaurants
            }else{
                return []
            }
    }
}

    extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == filterCollectionView{
                let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
                isFilterSelected[indexPath.row] = true
                cell.selectCell()
                filterRestaurantsShown()
            }else{
                return
            }
        }

        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            if collectionView == filterCollectionView{
                let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
                isFilterSelected[indexPath.row] = false
                cell.selectCell()
                filterRestaurantsShown()
            }else{
                return
            }
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == restaurantCollectionView{
                return restaurantsShown.count
            }else{
                return filters.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == restaurantCollectionView{
                if isRestaurantsShownLinearLayout{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: linearRestaurantReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell

                    cell.configure(for: restaurantsShown[indexPath.row])
                    return cell
                }else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
                    cell.isSelected = isFilterSelected[indexPath.row]
                    cell.configure(for: restaurantsShown[indexPath.row])
                    return cell
                }
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
                cell.configure(for: filters[indexPath.row].rawValue)
                cell.isSelected = isFilterSelected[indexPath.row]
                cell.selectCell()
                return cell
            }
        }
    }
    
    extension ViewController:UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == restaurantCollectionView{
                if isRestaurantsShownLinearLayout{
                    let width = collectionView.bounds.width - 5
                    
                    return CGSize(width: width, height: width * 1.2)
                }else{
                    let width = collectionView.bounds.width / 2 - 5
                    return CGSize(width: width, height: width * 1.2)
                }
            }else{
                let b = filters[indexPath.row].rawValue.count * 13
                
                return CGSize(width: CGFloat(b), height: collectionView.bounds.height - 1)
            }
        }
    }
    
    
    
    extension ViewController:UISearchResultsUpdating{
        
        func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text{
                if !searchText.isEmpty {
                    restaurantsShown = filterRestaurantsWithSearchText(searchText: searchText)
                    restaurantCollectionView.reloadData()
                }else{
                    restaurantsShown = restaurants
                    restaurantCollectionView.reloadData()
                }
            }
        }
}
