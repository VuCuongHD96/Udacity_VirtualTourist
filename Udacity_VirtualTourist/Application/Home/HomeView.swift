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
    
    var input: HomeViewModel.Input
    @ObservedObject var output: HomeViewModel.Output
    let cancelBag = CancelBag()
    
    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        let mapCameraPosition = MapCameraPosition.region(output.region)
        MapReader { proxy in
            Map(initialPosition: mapCameraPosition) {
                ForEach(output.pinItemViewArray, id: \.id) { pinItem in
                    Annotation("location.name", coordinate: pinItem.coordinate) {
                        Image(systemName: "star.circle")
                            .foregroundStyle(.yellow)
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .clipShape(.circle)
                            .onTapGesture {
                                input.annotationAction.send(pinItem)
                            }
                    }
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    input.pinLocation.send(coordinate)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    let homeViewModel = HomeViewModel()
    return HomeView(viewModel: homeViewModel)
}
