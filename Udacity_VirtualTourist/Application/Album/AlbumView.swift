//
//  AlbumView.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import SwiftUI

struct AlbumView: View {
    
    let columns = Array.init(repeating: GridItem(), count: 3)
    
    var body: some View {
        UdacityNavigationView {
            HStack {
                Image("previous")
                    .onTapGesture {
                        print("--- debug --- tap ALBUM")
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
                        ForEach((1...10), id: \.self) { item in
                            Rectangle()
                                .fill(randomColor(from: item))
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
    
    func randomColor(from number: Int) -> Color {
        let colors: [Color] = [
            .red, .green, .blue, .orange, .yellow, .pink, .purple, .gray, .black, .brown
        ]
        return colors[number % colors.count]
    }
}

#Preview {
    AlbumView()
}
