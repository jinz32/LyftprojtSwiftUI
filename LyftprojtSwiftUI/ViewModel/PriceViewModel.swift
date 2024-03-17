//
//  PriceViewModel.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/13/24.
//

import Foundation
import CoreLocation
import MapKit

final class PriceViewModel: NSObject, ObservableObject {
    var locationManager: CLLocationManager?
    
    var pickupLocation: Location
    var dropoffLocation: Location
    var quotes: [RideQuote]
    let rideQuoteService = RideQuoteService.quote
    
    @Published var defaultLocation = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // drop off test below
    @Published var testLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3387, longitude: 121.8853),span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    init(pickupLocation: Location, dropoffLocation: Location) {
        self.pickupLocation = pickupLocation
        self.dropoffLocation = dropoffLocation
        self.quotes = rideQuoteService.getQuotes(pickupLocation: pickupLocation, dropOffLocation: dropoffLocation)
        
    }
    
    func zoomIn() {
        defaultLocation.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    }
    
    
    func sayHello() {
        print("Hello")
    }
    
    func typeConverter(from defaultLocation: MKCoordinateRegion) -> Location{
        return Location(
            title: "Location Title",
            subtitle: "Location Subtitle",
            lat: defaultLocation.center.latitude,
            lng: defaultLocation.center.longitude
        )
    }
    
}
//extension PriceViewModel: CLLocationManagerDelegate { // wrote down here to seperate out from the top (style choice)
//    
//    private func checkLocationAuthorization() {
//        guard let location = locationManager else {
//            return
//        }
//        switch location.authorizationStatus {
//        case .notDetermined:
//            print("Location authorization is not determined.")
//        case .restricted:
//            print("Location is restricted.")
//        case .denied:
//            print("Location permission denied.")
//        case .authorizedAlways, .authorizedWhenInUse:
//            if location.location != nil {
//                defaultLocation = MKCoordinateRegion(
//                    center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
//                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                )
//            }
//            
//        default:
//            break
//        }
//    }
//    
//    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        // Handle changes in location authorization
//        let previousAuthorizationStatus = manager.authorizationStatus
//        manager.requestWhenInUseAuthorization()
//        if manager.authorizationStatus != previousAuthorizationStatus {
//            checkLocationAuthorization()
//            
//        }
//    }
//}
