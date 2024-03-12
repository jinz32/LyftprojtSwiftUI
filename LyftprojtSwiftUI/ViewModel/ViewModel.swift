//
//  SwiftUIView.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/11/24.
//

import SwiftUI
import CoreLocation
import MapKit

final class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
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

