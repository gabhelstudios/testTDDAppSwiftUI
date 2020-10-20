//
//  EditEmpleadoDB.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 20/10/20.
//

import SwiftUI

struct EditEmpleado: View {
    @EnvironmentObject var empleadosData:EmpleadosData
    @Environment(\.presentationMode) var presentation
    
    let empleado:Empleado
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var address = ""
    @State private var department = ""
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("First name").bold()
                TextField("Enter the first name", text: $firstName)
                    .textContentType(.name)
            }
            VStack(alignment: .leading) {
                Text("Last name").bold()
                TextField("Enter the last name", text: $lastName)
                    .textContentType(.familyName)
            }
            VStack(alignment: .leading) {
                Text("Email").bold()
                TextField("Enter the email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
            }
            VStack(alignment: .leading) {
                Text("Address").bold()
                    .textContentType(.fullStreetAddress)
                TextField("Enter the adress", text: $address)
            }
            VStack(alignment: .leading) {
                Text("Department").bold()
                HStack {
                    Text("\(department)")
                    Spacer()
                    Menu {
                        ForEach(Department.allCases
                            .sorted(by: { $0.rawValue > $1.rawValue }), id:\.self) { value in
                            Button(action: {
                                department = value.rawValue
                            }) {
                                Text("\(value.rawValue)")
                            }
                        }
                    } label: {
                        Text("Change")
                    }
                }
            }

            
        }
        .onAppear {
            firstName = empleado.firstName
            lastName = empleado.lastName
            email = empleado.email
            address = empleado.address
            department = empleado.department.rawValue
        }
        .navigationBarTitle("Edit employee")
        .navigationBarItems(trailing:
            Button(action: { save() }, label: {
                Text("Save")
            })
        )
    }
    
    func save() {
        let newEmpleado = Empleado(id: empleado.id, username: empleado.username, firstName: firstName, lastName: lastName, gender: empleado.gender, email: email, department: Department(rawValue: department)!, address: empleado.address, avatar: empleado.avatar, zipcode: empleado.zipcode)
        if let actualIndex = empleadosData.empleados.firstIndex(where: { $0.id == empleado.id }) {
            empleadosData.empleados[actualIndex] = newEmpleado
        }
        presentation.wrappedValue.dismiss()
    }
}

struct EditEmpleado_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditEmpleado(empleado: testEmpleado)
        }
    }
}
