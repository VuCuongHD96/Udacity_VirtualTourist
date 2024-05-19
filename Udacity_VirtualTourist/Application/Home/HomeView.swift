//
//  HomeView.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 17/5/24.
//

import SwiftUI
import MapKit

struct PinItemViewData: Identifiable {
    
    let id = UUID().uuidString
    let coordinate: CLLocationCoordinate2D
    var latitude: CLLocationDegrees {
        coordinate.latitude
    }
    var longitude: CLLocationDegrees {
        coordinate.longitude
    }
}

struct HomeView: View {
    
    @State private var pinItemViewArray: [PinItemViewData] = []
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(pinItemViewArray) { location in
                    Annotation("location.name", coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .clipShape(.circle)
                            .onTapGesture {
                                print("--- debug --- tap on Annotation Image")
                            }
                    }
                }
            }
            .onTapGesture { position in
                
                if let coordinate = proxy.convert(position, from: .local) {
                    print("--- debug --- tap on Map coordinate = ", coordinate)
                    let pinItemViewData = PinItemViewData(coordinate: coordinate)
                    pinItemViewArray.append(pinItemViewData)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
