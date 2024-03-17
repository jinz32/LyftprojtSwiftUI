//
//  RideQuoteService.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/14/24.
//

import Foundation
import CoreLocation

class RideQuoteService{
    static let quote = RideQuoteService()
    
    private init(){}
    
    func getQuotes(pickupLocation: Location, dropOffLocation: Location) -> [RideQuote]{
        let location1 = CLLocation(latitude: pickupLocation.lat, longitude: pickupLocation.lng)
        let location2 = CLLocation(latitude: dropOffLocation.lat, longitude: dropOffLocation.lng)
        
        let distance = location1.distance(from: location2)
        let minimumAmount = 3.0
        return[
            RideQuote(thumbnail: "ride-shared", name: "Shared", capacity: "1-2", price: minimumAmount + (distance * 0.0005), time: Date()),
            RideQuote(thumbnail: "ride-compact", name: "Shared", capacity: "4", price: minimumAmount + (distance * 0.0009), time: Date()),
            RideQuote(thumbnail: "ride-large", name: "Shared", capacity: "6", price: minimumAmount + (distance * 0.0015), time: Date())]
    }
}
