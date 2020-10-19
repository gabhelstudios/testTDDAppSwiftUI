//
//  ContentViewArray.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI

struct ContentViewArray: View {
    @EnvironmentObject var empleadosData:EmpleadosData
    var body: some View {
        NavigationView {
            List {
                ForEach(empleadosData.empleados) { empleado in
                    RowEmpleado(empleado: empleado)
                }
            }
            .navigationBarTitle("Empleados")
        }
    }
}

struct ContentViewArray_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewArray()
            .environmentObject(EmpleadosData())
    }
}

