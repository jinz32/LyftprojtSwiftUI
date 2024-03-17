//
//  MapView.swift
//  LyftprojtSwiftUI
//
//  Created by Jonathan Zheng on 3/6/24.
//
import CoreLocation
import SwiftUI
import MapKit


struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    
    struct MapContainerView: View {
        @ObservedObject var viewModel: MapViewModel
        var body: some View {
            Map(initialPosition: MapCameraPosition.region(viewModel.region), content: {
                Marker("", coordinate: viewModel.region.center)
            })
            .edgesIgnoringSafeArea(.top) // Align map to the top
        }
    }
    
    struct LocationCellView: View {
        let location: Location
        
        var body: some View {
            HStack{
                Image("location-custom")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .padding(.leading, 1)
                VStack(alignment: .leading) {
                    Text(location.title)
                        .font(.headline)
                    Text(location.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 10)
            }
            .background(Color.white)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader{ geometry in
                    VStack(alignment: .leading, spacing: 0) {
                        MapContainerView(viewModel: viewModel)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: geometry.size.height * 0.6) // Adjust the multiplier to stretch the map longer
                        headerText
                        
                        VStack{
                            searchButton
                            addressList
                        }
                    }
                }
                .padding(.bottom)
                .onAppear {
                    viewModel.sayHello()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    let leadingPadding: CGFloat = 10
    private var headerText: some View {
        VStack(alignment: .leading) {
            Text("Rise and Shine")
                .padding([.top, .leading], leadingPadding)
            Text("Where are you Going?")
                .bold()
                .padding([.top, .leading], leadingPadding)
        }
    }
    
    private var searchButton: some View {
        VStack {
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
                .shadow(radius: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.gray, lineWidth: 2)
                )
            }
            .padding(.trailing, 10)
        }
    }
    
    private var addressList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, content: {
                ForEach(viewModel.recentLocations, id: \.self) { location in
                    NavigationLink(destination: PriceView()) {
                        LocationCellView(location: location)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Divider()
                }
            })
        }
        .background(Color.white)
        .frame(height: 100)
    }
    
}
