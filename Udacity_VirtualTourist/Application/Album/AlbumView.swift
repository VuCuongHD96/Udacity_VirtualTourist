//
//  AlbumView.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import SwiftUI
import MapKit

struct AlbumView: View {
    
    let columns = Array.init(repeating: GridItem(), count: 3)
    let input: AlbumViewModel.Input
    @ObservedObject var output: AlbumViewModel.Output
    let cancelBag = CancelBag()
    
    init(viewModel: AlbumViewModel) {
        let input = AlbumViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        UdacityNavigationView {
            HStack {
                Image("previous")
                    .onTapGesture {
                        input.backAction.send()
                    }
                Spacer()
                Text("ALBUM")
                    .font(.title2)
                    .fontWeight(.medium)
                    .onTapGesture {
                        input.reloadAction.send(completion: .finished)
                    }
                Spacer()
                Image("refresh")
                    .rotationEffect(.degrees(output.degrees))
                    .allowsHitTesting(!output.isLoading)
                    .onTapGesture {
                        input.reloadAction.send()
                    }
            }
            .frame(height: 40)
            .padding(.horizontal)
        } bodyContent: {
            VStack {
                let mapCameraPosition = MapCameraPosition.region(output.region)
                Map(initialPosition: mapCameraPosition) {
                    Annotation(output.pinItem.name, coordinate: output.pinItem.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .background(.white)
                            .clipShape(.circle)
                            .frame(width: 40, height: 40)
                    }
                }
                .frame(height: 150)
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(output.albumItemViewDataArray, id: \.id) { item in
                            imageView(albumItem: item)
                                .cornerRadius(8)
                                .frame(height: 180)
                                .onTapGesture {
                                    input.deleteAction.send(item)
                                }
                        }
                    }
                    .animation(.easeInOut, value: output.albumItemViewDataArray)
                }
                .padding(8)
                .animation(.easeOut, value: output.isEditing)
            }
        }
        .alert(isPresented: $output.alertMessage.isShowing) {
            Alert(title: Text(output.alertMessage.title),
                  message: Text(output.alertMessage.message))
        }
    }
    
    private func imageView(albumItem: AlbumItemViewData) -> some View {
        if let photoData = albumItem.photoData,
           let uiImage = UIImage(data: photoData) {
            AnyView(
                Image(uiImage: uiImage)
                    .resizable()
                    .overlay(alignment: .bottomTrailing) {
                        Image("delete")
                            .offset(x: output.isEditing ? 0 : 38)
                            .clipped()
                            .animation(.easeInOut, value: output.isEditing)
                            .onTapGesture {
                                input.deleteAction.send(albumItem)
                            }
                            .frame(width: 30, height: 30)
                            .padding(8)
                            .allowsHitTesting(output.isEditing)
                    }
            )
        } else {
            AnyView(
                ProgressView()
            )
        }
    }
}

#Preview {
    let navigationController = UINavigationController()
    let albumRepository = AlbumServiceRepository(api: .share)
    let useCase = AlbumUseCase(albumRepository: albumRepository)
    let navigator = AlbumNavigator(navigationController: navigationController)
    let pinEntity = PinEntity(pinID: "", name: "", latitude: 0, longitude: 0)
    let viewModel = AlbumViewModel(useCase: useCase, navigator: navigator, pinEntity: pinEntity)
    return AlbumView(viewModel: viewModel)
}
