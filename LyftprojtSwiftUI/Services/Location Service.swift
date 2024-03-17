//
//  Location Service.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/12/24.
//

import Foundation
class LocationService{
    static let shared = LocationService()
    private var recentLocations = [Location]()
    
    private init(){
        let locationURL = Bundle.main.url(forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: locationURL)
        let decoder = JSONDecoder()
        recentLocations = try! decoder.decode([Location].self, from: data)
    }
    
    func getRecentLocations() -> [Location]{
        return recentLocations
    }
}
