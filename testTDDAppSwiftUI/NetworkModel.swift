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

    func imageDownload() {
        URLSession.shared.dataTaskPublisher(for: empleado.avatar)
            .map {
                $0.data
            }
            .compactMap {
                UIImage(data: $0)
            }
            .map {
                Image(uiImage: $0)
            }
            .replaceError(with: Image(uiImage: UIImage(systemName: "person.fill")!))
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
            .store(in: &subscribers)
    }
}

class ImageLoadNetworkDB: ObservableObject {
    @Published var image = Image(uiImage: UIImage(systemName: "person.fill")!)
    let empleado:EmpleadoDB
    var subscribers = Set<AnyCancellable>()
    
    init(empleado:EmpleadoDB) {
        self.empleado = empleado
    }

    func imageDownload() {
        URLSession.shared.dataTaskPublisher(for: empleado.avatar!)
            .map {
                $0.data
            }
            .compactMap {
                UIImage(data: $0)
            }
            .map {
                Image(uiImage: $0)
            }
            .replaceError(with: Image(uiImage: UIImage(systemName: "person.fill")!))
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
            .store(in: &subscribers)
    }
}
