//
//  RowEmpleadoDB.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI

struct RowEmpleadoDB: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var empleado:EmpleadoDB
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(empleado.lastName ?? ""), \(empleado.firstName ?? "")")
                    .bold()
                Text("\(empleado.email ?? "")")
                    .font(.caption)
            }
            Spacer()
            if let data = empleado.avatarIMG, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 44)
                    .background(Color.gray)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 44)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
        }
        .onAppear {
            if empleado.avatarIMG == nil {
                let image = ImageLoadNetworkDB(empleado: empleado, ctx: context)
                image.imageDownload()
            }
        }
    }
}

struct RowEmpleadoDB_Previews: PreviewProvider {
    static var previews: some View {
        RowEmpleadoDB(empleado: testDataEmpleadosDB())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
