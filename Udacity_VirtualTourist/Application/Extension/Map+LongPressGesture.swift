//
//  Map+LongPressGesture.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 31/5/24.
//

import SwiftUI
import MapKit

extension Map {
    func onLongPressGesture(minimumDuration: Double = 0,
                            maximumDistance: CGFloat = 0,
                            onTouchUp: @escaping (CGPoint) -> Void) -> some View {
        self
            .gesture(DragGesture())
            .gesture(
                LongPressGesture(minimumDuration: minimumDuration, maximumDistance: maximumDistance)
                    .sequenced(before: SpatialTapGesture(coordinateSpace: .local))
                    .onEnded { value in
                        switch value {
                        case .second(_, let tapValue):
                            guard let point = tapValue?.location else {
                                print("Unable to retreive tap location from gesture data.")
                                return
                            }
                            onTouchUp(point)
                        default: return
                        }
                    }
            )
    }
}
