//
//  Pizza.swift
//  PIZZA_ANAS_AZBEMAT
//
//

import Foundation

class Pizza{
    
  var name:String
  var description:String
  var sizeWithPrice:[String:Double] = [:]

  init(name:String, description:String, sizeWithPrice:[String:Double]){
    self.name = name
    self.description = description
    self.sizeWithPrice = sizeWithPrice
  }
}

// Dictionary - common data [size and price of pizza]
let baseSizeWithPrice:[String:Double] = [
  "Small": 15.50,
  "Medium": 17.50,
  "Large": 21.50
]

