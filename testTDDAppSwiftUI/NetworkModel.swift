//
//  NetworkModel.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI
import Combine

class ImageLoadNetwork: ObservableObject {
    @Published var image = Image(uiImage: UIImage(systemName: "person.fill")!)
    let empleado:Empleado
    var subscribers = Set<AnyCancellable>()
    
    init(empleado:Empleado) {
        self.empleado = empleado
    }
    
    func publisherImage() -> AnyPublisher<Image,Never> {
        URLSession.shared.dataTaskPublisher(for: empleado.avatar)
            .map {
                print("HOla")
                return $0.data
            }
            .compactMap {
                UIImage(data: $0)
            }
            .replaceEmpty(with: UIImage(systemName: "person.fill")!)
            .map {
                Image(uiImage: $0)
            }
            .replaceError(with: Image(uiImage: UIImage(systemName: "person.fill")!))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func imageDownload() {
        publisherImage()
            .assign(to: \.image, on: self)
            .store(in: &subscribers)
    }
}
