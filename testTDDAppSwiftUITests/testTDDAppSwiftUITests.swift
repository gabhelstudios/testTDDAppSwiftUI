//
//  testTDDAppSwiftUITests.swift
//  testTDDAppSwiftUITests
//
//  Created by Julio César Fernández Muñoz on 19/10/20.
//

import XCTest
import SwiftUI
import Combine

@testable import testTDDAppSwiftUI

class testTDDAppSwiftUITests: XCTestCase {
    
    var empleados = EmpleadosData()
    var networkModel:ImageLoadNetwork!
    var subscribers = Set<AnyCancellable>()
    
    let testEmpleadoGood = Empleado(id: 1, username: "stevejobs", firstName: "Steve", lastName: "Jobs", gender: .male, email: "steve@mac.com", department: .businessDevelopment, address: "Cupertino", avatar: URL(string: "https://hiperbeta.com/wp-content/uploads/2010/02/steve-jobs-talking.jpg")!, zipcode: nil)
    let testEmpleadoBad = Empleado(id: 1, username: "stevejobs", firstName: "Steve", lastName: "Jobs", gender: .male, email: "steve@mac.com", department: .businessDevelopment, address: "Cupertino", avatar: URL(string: "https://hiperbeta.com/wp-content/uploads/2010/02/stjobs-talking.jpg")!, zipcode: nil)


    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testImageDownloadInvalidAvatar() {
        let exp = expectation(description: "Debe devolver la imagen por defecto")
        networkModel = ImageLoadNetwork(empleado: testEmpleadoGood)
        networkModel.publisherImage().sink(receiveValue: {
            let imagenDefecto = Image(uiImage: UIImage(systemName: "person.fill")!)
            XCTAssertFalse($0 == imagenDefecto, "La imagen devuelta es la imagen por defecto")
            exp.fulfill()
        })
        .store(in: &subscribers)
        waitForExpectations(timeout: 3, handler: nil)
     }
}
