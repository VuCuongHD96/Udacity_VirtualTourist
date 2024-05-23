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
    
    let input: HomeViewModel.Input
    @ObservedObject var output: HomeViewModel.Output
    let cancelBag = CancelBag()
    @State private var annotationTapped = false

    
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
                              .foregroundStyle(.red)
                              .background(.white)
                              .clipShape(.circle)
                              .frame(width: 35, height: 35)
                              .onTapGesture {
                                  print("\n\n--- debug --- tap on Annotation Image\n\n")
                                  input.annotationAction.send(pinItem)
                                  annotationTapped = true
                              }
                      }
                  }
              }
              .onTapGesture { position in
                  if annotationTapped {
                      annotationTapped = false
                  } else if let coordinate = proxy.convert(position, from: .local) {
                      print("--- debug --- pinAction")
                      input.pinAction.send(coordinate)
                  }
              }
          }
        .ignoresSafeArea()
    }
}

#Preview {
    let homeViewModel = HomeViewModel()
    return HomeView(viewModel: homeViewModel)
}
