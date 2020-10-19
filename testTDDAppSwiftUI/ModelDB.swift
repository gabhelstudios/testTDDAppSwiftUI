//
//  ModelDB.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI
import CoreData

func loadDataEmpleadosDB() {
    guard let ruta = Bundle.main.url(forResource: "EmpleadosData", withExtension: "json") else {
        return
    }
    let ctx = PersistenceController.shared.container.viewContext
    do {
        let data = try Data(contentsOf: ruta)
        let empleados = try JSONDecoder().decode(Empleados.self, from: data)
        empleados.forEach {
            let countFetch:NSFetchRequest<EmpleadoDB> = EmpleadoDB.fetchRequest()
            let predicate = NSPredicate(format: "%K == %@", "id", NSNumber(value: $0.id))
            countFetch.predicate = predicate
            let count = (try? ctx.count(for: countFetch)) ?? 0
            if count == 0 {
                let newEmpleado = EmpleadoDB(context: ctx)
                newEmpleado.id = Int16($0.id)
                newEmpleado.firstName = $0.firstName
                newEmpleado.lastName = $0.lastName
                newEmpleado.gender = $0.gender.rawValue
                newEmpleado.email = $0.email
                newEmpleado.address = $0.address
                newEmpleado.username = $0.username
                newEmpleado.avatar = $0.avatar
                let dptoFetch:NSFetchRequest<DepartmentDB> = DepartmentDB.fetchRequest()
                let dptoPredicate = NSPredicate(format: "%K = %@", #keyPath(DepartmentDB.dpto), $0.department.rawValue)
                dptoFetch.predicate = dptoPredicate
                do {
                    let dpto = try ctx.fetch(dptoFetch)
                    if let departamento = dpto.first {
                        newEmpleado.department = departamento
                    } else {
                        let newDpto = DepartmentDB(context: ctx)
                        newDpto.dpto = $0.department.rawValue
                        newEmpleado.department = newDpto
                    }
                } catch {
                    print("Fallo al recuperar el departamento \(error)")
                }
            }
            try? ctx.save()
        }
    } catch {
        print("Error en la carga \(error)")
    }
}
