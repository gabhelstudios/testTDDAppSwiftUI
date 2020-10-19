//
//  Model.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI
import Combine

struct Empleado: Codable, Identifiable, Hashable {
    let id: Int
    var username, firstName, lastName: String
    var gender: Gender
    var email: String
    var department: Department
    var address: String
    var avatar: URL
    var zipcode: String?

    enum CodingKeys: String, CodingKey {
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
        case gender, email, department, address, avatar, zipcode
    }
}

enum Department: String, Codable, CaseIterable {
    case accounting = "Accounting"
    case businessDevelopment = "Business Development"
    case engineering = "Engineering"
    case humanResources = "Human Resources"
    case legal = "Legal"
    case marketing = "Marketing"
    case productManagement = "Product Management"
    case researchAndDevelopment = "Research and Development"
    case sales = "Sales"
    case services = "Services"
    case support = "Support"
    case training = "Training"
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

typealias Empleados = [Empleado]

class EmpleadosData: ObservableObject {
    @Published var empleados:Empleados = [] {
        didSet {
            save()
        }
    }
    
    init() {
        empleados = loadDataEmpleados()
    }
    
    func loadDataEmpleados() -> Empleados {
        guard var ruta = Bundle.main.url(forResource: "EmpleadosData", withExtension: "json"),
              let rutaDoc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        let rutaFile = rutaDoc.appendingPathComponent("EmpleadosData").appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: rutaFile.path) {
            ruta = rutaFile
        }
        do {
            let data = try Data(contentsOf: ruta)
            return try JSONDecoder().decode(Empleados.self, from: data)
        } catch {
            print("Error en la carga \(error)")
        }
        return []
    }
    
    func save() {
        guard let rutaDoc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let rutaFile = rutaDoc.appendingPathComponent("EmpleadosData").appendingPathExtension("json")
        do {
            let dataJSON = try JSONEncoder().encode(empleados)
            DispatchQueue.global(qos: .background).async {
                do {
                    try dataJSON.write(to: rutaFile, options: [.atomicWrite, .completeFileProtection])
                } catch {
                    print("Error en la grabación \(error)")
                }
            }
        } catch {
            print("Error en la grabación \(error)")
        }
    }
}

let testEmpleado = Empleado(id: 1, username: "test", firstName: "Empleado", lastName: "De Prueba", gender: .male, email: "prueba@test.com", department: .accounting, address: "", avatar: URL(string: "https://robohash.org/quaminventoredolorem.png")!, zipcode: nil)
