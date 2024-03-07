//
//  MapView.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/6/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    //let mapViewModel = mapViewViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarHidden(true)
                    .onAppear { } // add stuff here later for on appear
                HStack{
                    Image("search")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 15, height: 15)
                        .padding()
                    
                    Button("Search Destination") {
                        
                    }
                    .background(Color.white)
                    .foregroundColor(.gray)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                }
                
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

#Preview {
    MapView()
}
