//
//  ContentViewArray.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var empleadosData:EmpleadosData
    var body: some View {
        NavigationView {
            List {
                ForEach(section(empleadosData.empleados), id:\.self) { section in
                    Section(header: Text(section[0].department.rawValue.capitalized)) {
                        ForEach(section, id:\.self) { empleado in
                            NavigationLink(
                                destination: EditEmpleado(empleado: empleado),
                                label: {
                                    RowEmpleado(empleado: empleado)
                                })
                        }
                    }
                }
            } 
            .navigationBarTitle("Listado Empleados")
        }
    }
    
    func section(_ result: Empleados) -> [[Empleado]] {
        Dictionary(grouping: result) { (element: Empleado) in
            element.department.rawValue
        }.values.map { $0 }.sorted(by: { $0.first?.department.rawValue ?? "" < $1.first?.department.rawValue ?? "" })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EmpleadosData())
    }
}

