//
//  AlbumView.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import SwiftUI

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
                Spacer()
                Image("refresh")
//                    .rotationEffect(.degrees(output.degrees))
//                    .allowsHitTesting(!output.isLoading)
                    .onTapGesture {
                        input.reloadAction.send()
                    }
            }
            .frame(height: 40)
            .padding(.horizontal)
        } bodyContent: {
            VStack {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(output.albumItemViewDataArray, id: \.id) { item in
                            imageView(albumItem: item)
                                .cornerRadius(8)
                                .frame(height: 180)
                        }
                    }
                    .animation(.easeInOut, value: output.albumItemViewDataArray)
                }
                .padding(8)
                Spacer()
                HStack(spacing: 0) {
                    if output.isEditing {
                        doneEditingView
                    } else {
                        editView
                    }
                }
                .animation(.easeOut, value: output.isEditing)
                .frame(height: 40)
            }
        }
    }
    
    private var editView: some View {
        Text("Edit Mode")
            .font(.title2)
            .foregroundColor(.white.opacity(0.8))
            .fontWeight(.bold)
            .ignoresSafeArea(edges: .bottom)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red.opacity(0.8))
            .onTapGesture {
                input.editMode.send(.editing)
            }
    }
    
    private var doneEditingView: some View {
        Text("Done Editing")
            .font(.title2)
            .foregroundColor(.white.opacity(0.8))
            .fontWeight(.bold)
            .ignoresSafeArea(edges: .bottom)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.8))
            .onTapGesture {
                input.editMode.send(.doneEdit)
            }
    }
    
    private func imageView(albumItem: AlbumItemViewData) -> some View {
        AsyncImage(url: URL(string: albumItem.imageUrlString)) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
        }
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
//                .allowsHitTesting(output.isEditing)
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
