//
//  UdacityNavigationHeaderView.swift
//  MovieSwiftUI
//
//  Created by Work on 11/03/2023.
//

import SwiftUI

struct UdacityNavigationHeaderView<Content: View>: View {
    
    // MARK: - Define
    typealias ContentHandler = () -> Content
    
    // MARK: - Property
    let content: Content
    
    // MARK: - Init
    init(@ViewBuilder content: ContentHandler) {
        self.content = content()
    }
    
    // MARK: - View
    var body: some View {
        content
    }
}

struct MovieNavigationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UdacityNavigationHeaderView {
            HStack {
                Text("Left button")
                Spacer()
                Text("Right button")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
