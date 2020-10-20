//
//  RowEmpleadoDB.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI

struct RowEmpleadoDB: View {
    let empleado:EmpleadoDB
    @ObservedObject var imageContainer:ImageLoadNetworkDB
    
    init(empleado:EmpleadoDB) {
        self.empleado = empleado
        self.imageContainer = ImageLoadNetworkDB(empleado: empleado)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(empleado.lastName ?? ""), \(empleado.firstName ?? "")")
                    .bold()
                Text("\(empleado.email ?? "")")
                    .font(.caption)
            }
            Spacer()
            imageContainer.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 44)
                .background(Color.gray)
                .clipShape(Circle())
        }
        .onAppear {
            imageContainer.imageDownload()
        }
    }
}

struct RowEmpleadoDB_Previews: PreviewProvider {
    static var previews: some View {
        RowEmpleadoDB(empleado: testDataEmpleadosDB())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
