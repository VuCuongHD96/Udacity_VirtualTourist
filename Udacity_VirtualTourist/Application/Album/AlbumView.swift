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
                        input.backAction.send(Void())
                    }
                Spacer()
                Text("ALBUM")
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Image("previous")
                    .opacity(0) 
            }
            .frame(height: 40)
            .padding(.horizontal)
        } bodyContent: {
            VStack {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(output.albumItemViewDataArray, id: \.id) { item in
                            AsyncImage(url: URL(string: item.imageUrlString)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 180)
                        }
                    }
                }
                Text("New Collection")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                    .fontWeight(.bold)
                    .ignoresSafeArea(edges: .bottom)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .onTapGesture {
                        print("--- debug --- tap New Collection")
                    }
            }
        }
    }
}

#Preview {
    let navigationController = UINavigationController()
    let useCase = AlbumUseCase()
    let navigator = AlbumNavigator(navigationController: navigationController)
    let pinItemViewData = PinItemViewData(coordinate: .init())
    let viewModel = AlbumViewModel(useCase: useCase, navigator: navigator, pinItemViewData: pinItemViewData)
    return AlbumView(viewModel: viewModel)
}
