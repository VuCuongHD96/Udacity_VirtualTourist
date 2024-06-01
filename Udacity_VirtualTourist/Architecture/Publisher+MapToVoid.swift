//
//  Publisher+MapToVoid.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 1/6/24.
//

import Combine

extension Publisher {
    
    func mapToVoid() -> Publishers.Map<Self, Void> {
        self.map { _ in
            Void()
        }
    }
}
