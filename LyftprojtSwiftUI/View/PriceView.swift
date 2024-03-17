//
//  PriceView.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/13/24.
//
import CoreLocation
import MapKit
import SwiftUI

struct PriceView: View {
    private let locationManager = CLLocationManager()
    //    @State private var region = MKCoordinateRegion(
    //        center: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227),
    //        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    //    )
    @ObservedObject var mapView: MapViewModel
    @ObservedObject var viewModel = PriceViewModel(pickupLocation: Location(title: "abc", subtitle: "abc", lat: 37.787359, lng: -122.408227), dropoffLocation: Location(title: "def", subtitle: "def", lat: 37.3387, lng: -121.8853))
    
    init(){
        self.mapView = MapViewModel()
        self.viewModel = PriceViewModel(pickupLocation: Location(title: "abc", subtitle: "abc", lat: 37.787359, lng: -122.408227), dropoffLocation: Location(title: "def", subtitle: "def", lat: 37.3387, lng: -121.8853))
    }
    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                    MapContainerView(viewModel: mapView)
                        .edgesIgnoringSafeArea(.all)
                    backButton
                        .offset(x: -175, y:140)
                }
                    pricingList
            }
        }
        .navigationBarHidden(true)
    }
    
    struct MapContainerView: View {
        @ObservedObject var viewModel: MapViewModel
        var body: some View {
            Map(initialPosition: MapCameraPosition.region(viewModel.region), content: {
                Marker("", coordinate: viewModel.region.center)
            })
            .edgesIgnoringSafeArea(.top) // Align map to the top
        }
    }
    
    struct PricingCellView: View {
        let quote: RideQuote
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mma"
            return formatter
        }
        
        var body: some View {
            HStack{
                Image("\(quote.thumbnail)")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .padding(.leading, 25)
                VStack(spacing:0){
                    Text(quote.name)
                        .font(.headline)
                    HStack{
                        Image("person")
                        Text(quote.capacity)
                            .font(.subheadline)
                    }
                    .padding(.leading,3)
                }
                .padding(.leading,15)
                Spacer()
                VStack(spacing: 0){
                    Text(String(format: "$%.2f",(quote.price)))
                        .font(.headline)
                    Text(dateFormatter.string(from: quote.time))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.trailing, 10)
            }
        }
    }
    
    private var backButton: some View {
        NavigationLink(destination: MapView()) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(0.8)
                Image("back-arrow")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
            }
        }
        .navigationBarHidden(true)
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default button styling
    }
    
    private var pricingList: some View{
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.quotes, id: \.self){ quote in
                    PricingCellView(quote: quote)
                    Divider()
                }
                // Use any view to display the quote information
            }
        }
    }
}


