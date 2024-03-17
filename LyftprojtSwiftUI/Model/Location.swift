//
//  Location.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/12/24.
//

import Foundation

class Location: Identifiable, Decodable, Hashable {
    static func == (lhs: Location, rhs: Location) -> Bool {
//        print("===========================")
//
//        print("Comparison Divider")
//        print("\(lhs.lat)     \(lhs.lng)")
//        print("\(rhs.lat)     \(rhs.lng)")
//        print("===========================")
        return lhs.lat == rhs.lat && lhs.lng == rhs.lng && lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
    }
    
    var title: String
    var subtitle: String
    let lat: Double
    let lng: Double
    
    init(title: String, subtitle: String, lat: Double, lng: Double) {
        self.title = title
        self.subtitle = subtitle
        self.lat = lat
        self.lng = lng
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(lat)
        hasher.combine(lng)
    }
}


