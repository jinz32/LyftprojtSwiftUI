//
//  MapView.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/6/24.
//
import CoreLocation
import SwiftUI
import MapKit

struct AnnotationView: View {
    var body: some View {
        Text("Hello")
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var annotations = [MapAnnotation<AnnotationView>]()
    
    //decided to put here
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Map(initialPosition: MapCameraPosition.region(region), content: {
                    Marker("Hello", coordinate: region.center)
                })
                // request for authorization then
                
                // add stuff here later for on appear
                Text("Rise and Shine")
                    .padding()
                Text("Where are you Going?")
                    .bold()
                    .padding()
                HStack{
                    
                    Image("search")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 15, height: 15)
                        .padding()
                    
                    Button("Search Destination") {
                        
                    }
                    
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.gray)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                }
                .padding(.trailing, 10)
                
                HStack{
                    Image("location-custom")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 15, height: 15)
                        .padding()
                    VStack{
                        Text("Location One")
                            .font(.headline.bold())
                            .foregroundStyle(.black)
                        Text("Location one address")
                            .foregroundStyle(.gray)
                            .font(.caption.italic())
                    }
                }
            }
            .frame(height: geometry.size.height)
        }
    }
}
//
