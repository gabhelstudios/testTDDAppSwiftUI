//
//  EditEmpleadoDB.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 20/10/20.
//

import SwiftUI

struct EditEmpleadoDB: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var empleado:EmpleadoDB
    @Environment(\.presentationMode) var presentation
    
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
            firstName = empleado.firstName ?? ""
            lastName = empleado.lastName ?? ""
            email = empleado.email ?? ""
            address = empleado.address ?? ""
            department = empleado.department?.dpto ?? ""
        }
        .navigationBarTitle("Edit employee")
        .navigationBarItems(trailing:
            Button(action: { save() }, label: {
                Text("Save")
            })
        )
    }
    
    func save() {
        empleado.firstName = firstName
        empleado.lastName = lastName
        empleado.email = email
        empleado.address = address
        empleado.department = DepartmentDB.queryData(field: #keyPath(DepartmentDB.dpto), filter: department, context: context)
        try? context.save()
        presentation.wrappedValue.dismiss()
    }
}

struct EditEmpleadoDB_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditEmpleadoDB(empleado: testDataEmpleadosDB())
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
