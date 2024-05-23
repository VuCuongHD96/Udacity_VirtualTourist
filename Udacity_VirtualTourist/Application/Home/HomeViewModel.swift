//
//  HomeViewModel.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 19/5/24.
//

import Foundation
import MapKit
import Combine

struct HomeViewModel {
    
}

extension HomeViewModel: ViewModel {
    
    enum MapAction {
        case pin(CLLocationCoordinate2D)
        case annotation(PinItemViewData?)
    }
    
    struct Input {
        var loadTrigger = PassthroughSubject<Void, Never>()
        var pinAction = PassthroughSubject<CLLocationCoordinate2D, Never>()
        var annotationAction = PassthroughSubject<PinItemViewData?, Never>()
    }
    
    class Output: ObservableObject {
        @Published var region: MKCoordinateRegion = .init()
        @Published var pinItemViewArray = [PinItemViewData]()
    }
    
    
    private func processPinAction(_ pinCoordinate: CLLocationCoordinate2D, output: Output) {
        let pinItemViewData = PinItemViewData(coordinate: pinCoordinate)
        output.pinItemViewArray.append(pinItemViewData)
        print("--- debug --- pinItemViewArray.count = ", output.pinItemViewArray.count)
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loadTrigger.map { _ in
            let coordinate = CLLocationCoordinate2D(latitude: 21.043507, longitude: 105.836508)
            let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            return MKCoordinateRegion(center: coordinate, span: coordinateSpan)
        }
        .assign(to: \.region, on: output)
        .store(in: cancelBag)
        
        let check = 
        input.annotationAction
            .map {
                $0 != nil
            }
            .handleEvents(receiveOutput: {
                print("--- debug --- check 1 = ", $0)
            })
//            .store(in: cancelBag)
        
//        Publishers.Zip(input.pinAction, check)
//            .filter { (_, check) in
//                print("--- debug --- check 2 = ", check)
//              return  check == false
//            }
//            .map { locationCoordinate, _ in
//                PinItemViewData(coordinate: locationCoordinate)
//            }
//            .sink { pinItemViewData in
//                output.pinItemViewArray.append(pinItemViewData)
//                print("--- debug --- pinItemViewArray.cout = ", output.pinItemViewArray.count)
//            }
//            .store(in: cancelBag)
        
        input.pinAction
            .map { locationCoordinate in
                PinItemViewData(coordinate: locationCoordinate)
            }
            .sink { pinItemViewData in
                output.pinItemViewArray.append(pinItemViewData)
                print("--- debug --- pinItemViewArray.cout = ", output.pinItemViewArray.count)
            }
            .store(in: cancelBag)
        
        //        input.annotationAction
        //            .filter { pinItemViewData in
        //                pinItemViewData == nil
        //            }
        //            .flatMap { _ in
        //                input.pinAction
        //            }
        //            .removeDuplicates(by: {
        //                $0.latitude == $1.latitude
        //            })
        //            .map { locationCoordinate in
        //                PinItemViewData(coordinate: locationCoordinate)
        //            }
        //            .sink { pinItemViewData in
        //                output.pinItemViewArray.append(pinItemViewData)
        //                print("--- debug --- pinItemViewArray.cout = ", output.pinItemViewArray.count)
        //            }
        //            .store(in: cancelBag)
        //
        //                input.annotationAction
        //                    .compactMap { $0 }
        //                    .sink(receiveValue: {
        //                        print("--- debug --- annotationAction = ", $0)
        //                    })
        //                    .store(in: cancelBag)
        

        

        return output
    }
    
    
}


// tap vào Map -> lấy location
// tap vào Pin -> lấy ảnh
