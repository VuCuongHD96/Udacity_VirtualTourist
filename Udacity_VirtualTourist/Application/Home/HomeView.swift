//
//  HomeView.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 17/5/24.
//

import SwiftUI
import MapKit

struct PinItemViewData: Identifiable {
    let id: String
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
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
                            .resizable()
                            .foregroundStyle(.yellow)
                            .background(.white)
                            .clipShape(.circle)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                input.annotationAction.send(pinItem)
                            }
                    }
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    input.pinAction.send(coordinate)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    let navigationController = UINavigationController()
    let navigator = HomeNavigator(navigationController: navigationController)
    let homeViewModel = HomeViewModel(navigator: navigator)
    return HomeView(viewModel: homeViewModel)
}
