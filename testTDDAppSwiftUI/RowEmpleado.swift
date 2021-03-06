//
//  RowEmpleado.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI

struct RowEmpleado: View {
    let empleado:Empleado
    @ObservedObject var imageContainer:ImageLoadNetwork
    
    init(empleado:Empleado) {
        self.empleado = empleado
        self.imageContainer = ImageLoadNetwork(empleado: empleado)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(empleado.lastName), \(empleado.firstName)")
                    .bold()
                    .accessibility(identifier: "Full Name")
                Text("\(empleado.email)")
                    .font(.caption)
                    .accessibility(identifier: "Email")
            }
            Spacer()
            imageContainer.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 44)
                .background(Color.gray)
                .clipShape(Circle())
                .accessibility(hidden: true)
        }
        .onAppear {
            imageContainer.imageDownload()
        }
    }
}

struct RowEmpleado_Previews: PreviewProvider {
    static var previews: some View {
        RowEmpleado(empleado: testEmpleado)
    }
}
