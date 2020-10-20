//
//  NetworkModel.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI
import Combine
import CoreData

class ImageLoadNetworkDB {
    let empleado:EmpleadoDB
    var subscribers = Set<AnyCancellable>()
    let ctx:NSManagedObjectContext
    
    init(empleado:EmpleadoDB, ctx:NSManagedObjectContext) {
        self.empleado = empleado
        self.ctx = ctx
    }

    func imageDownload() {
        URLSession.shared.dataTaskPublisher(for: empleado.avatar!)
            .map {
                $0.data
            }
            .compactMap {
                UIImage(data: $0)
            }
            .replaceError(with: UIImage(systemName: "person.fill")!)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [self] image in
                empleado.avatarIMG = image.pngData()
                try? ctx.save()
            })
            .store(in: &subscribers)
    }
}
