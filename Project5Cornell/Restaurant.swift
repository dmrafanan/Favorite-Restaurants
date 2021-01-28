//
//  Restaurant.swift
//  Project5Cornell
//
//  Created by Daniel Marco S. Rafanan on Jul/31/20.
//  Copyright © 2020 Daniel Marco S. Rafanan. All rights reserved.
//
protocol FilterProtocol {
    
}
import Foundation

struct Restaurant{
    var name:String
    var category:RestaurantAttributes.Category
    var price:RestaurantAttributes.Price
    var rating:RestaurantAttributes.Rating
    var cuisine:RestaurantAttributes.Cuisine
    var imageName:String
    
    func containsFilters(categories:[RestaurantAttributes.Category],prices:[RestaurantAttributes.Price],ratings:[RestaurantAttributes.Rating],cuisines:[RestaurantAttributes.Cuisine]) -> Bool{
        if categories.contains(category) && prices.contains(price) && ratings.contains(rating) && cuisines.contains(cuisine){
            return true
        }else{
            return false
        }
    }
    
    func attributes() -> [String]{
        return [name,category.rawValue,price.rawValue,rating.rawValue,cuisine.rawValue]
    }
}

class RestaurantAttributes{
    enum Category:String,CaseIterable,CustomStringRepresentableEnum{
        case fastfood = "Fast Food",
        fineDine = "Fine Dine",
        buffet = "Buffet",
        coffeeShop = "Coffee Shop",
        casual = "Casual",
        samgyeopsal = "Samgyeopsal"
    }
    enum Price:String,CaseIterable,CustomStringRepresentableEnum{
        case cheap = "Cheap",
        average = "Average",
        expensive = "Expensive"
    }
    enum Rating:String,CaseIterable,CustomStringRepresentableEnum{
        case one = "One",two = "Two",three = "Three",four = "Four",five = "five"
    }
    enum Cuisine:String,CaseIterable,CustomStringRepresentableEnum{
        case american = "American",
        assorted = "Assorted",
        filipino = "Filipino",
        chinese = "Chinese",
        korean = "Korean",
        seafood = "Seafood"
    }
}


protocol CustomStringRepresentableEnum {
    var rawValue: String { get }
}
