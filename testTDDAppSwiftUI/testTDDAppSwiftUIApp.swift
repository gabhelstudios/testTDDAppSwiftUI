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
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        loadDataEmpleadosDB()
        return WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            ContentViewArray()
//                .environmentObject(empleadosData)
        }
    }
}

class AppDelegate:NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        loadDataEmpleadosDB()
    }
}
