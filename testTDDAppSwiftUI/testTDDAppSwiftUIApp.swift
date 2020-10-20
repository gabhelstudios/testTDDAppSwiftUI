//
//  testTDDAppSwiftUIApp.swift
//  testTDDAppSwiftUI
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import SwiftUI

@main
struct testTDDAppSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var empleadosData = EmpleadosData()

    var body: some Scene {
        loadDataEmpleadosDB()
        return WindowGroup {
            ContentViewDB()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
//        WindowGroup {
//            ContentView()
//                .environmentObject(empleadosData)
//        }
    }
}

