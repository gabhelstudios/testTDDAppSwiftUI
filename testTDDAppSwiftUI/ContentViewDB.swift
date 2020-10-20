//
//  ContentView.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: EmpleadoDB.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)])
        var empleadosConsulta:FetchedResults<EmpleadoDB>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(section(empleadosConsulta), id:\.self) { section in
                    if let dpto = section[0].department?.dpto {
                        Section(header: Text(dpto)) {
                            ForEach(section, id:\.self) { empleado in
                                NavigationLink(destination: EditEmpleadoDB(empleado: empleado)) {
                                    RowEmpleadoDB(empleado: empleado)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Listado Empleados")
        }
    }
    
    func section(_ result: FetchedResults<EmpleadoDB>) -> [[EmpleadoDB]] {
        Dictionary(grouping: result) { (element: EmpleadoDB) in
            element.department?.dpto ?? ""
        }.values.map { $0 }.sorted(by: { $0.first?.department?.dpto ?? "" < $1.first?.department?.dpto ?? "" })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        _ = testDataEmpleadosDB()
        return ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
