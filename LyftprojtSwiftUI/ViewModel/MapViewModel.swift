//
//  SwiftUIView.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/11/24.
//


import CoreLocation
import MapKit

final class MapViewModel: NSObject, ObservableObject {
    var locationManager: CLLocationManager?
        
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    let recentLocations = LocationService.shared.getRecentLocations()
    
    init(locationManager: CLLocationManager? = nil, region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )) {
        self.locationManager = locationManager
        self.region = region
//        super.init()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//                    // Update the region to Los Angeles coordinates after 5 seconds
//                    self?.region = MKCoordinateRegion(
//                        center: CLLocationCoordinate2D(latitude: 37.8048, longitude: -122.2711), // Los Angeles coordinates
//                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                    )
//                }
    }
       
    
    func sayHello() {
        print("Hello")
    }
  
   private func checkIfLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off")
        }
    }
}

extension MapViewModel: CLLocationManagerDelegate { // wrote down here to seperate out from the top (style choice)
    
    private func checkLocationAuthorization() {
        guard let location = locationManager else {
            return
        }
        switch location.authorizationStatus {
        case .notDetermined:
            print("Location authorization is not determined.")
        case .restricted:
            print("Location is restricted.")
        case .denied:
            print("Location permission denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            if location.location != nil {
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            }
            
        default:
            break
        }
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Handle changes in location authorization
        let previousAuthorizationStatus = manager.authorizationStatus
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus != previousAuthorizationStatus {
            checkLocationAuthorization()
            
        }
    }
}
