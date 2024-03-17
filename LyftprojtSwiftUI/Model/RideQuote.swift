//
//  RideQuote.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/14/24.
//

import Foundation

class RideQuote: Identifiable, Hashable{
    let thumbnail: String
    let name: String
    let capacity: String
    let price: Double
    let time: Date
    
    init(thumbnail: String, name: String, capacity: String, price: Double, time: Date) {
        self.thumbnail = thumbnail
        self.name = name
        self.capacity = capacity
        self.price = price
        self.time = time
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(price)
        hasher.combine(price)
    }
    static func == (lhs: RideQuote, rhs: RideQuote) -> Bool {
        return lhs.price == rhs.price
    }
}
