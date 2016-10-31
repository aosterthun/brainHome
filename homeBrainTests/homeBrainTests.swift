//
//  homeBrainTests.swift
//  homeBrainTests
//
//  Created by Arne Osterthun on 31.10.16.
//  Copyright © 2016 Arne Osterthun. All rights reserved.
//

import XCTest
import CoreData
@testable import homeBrain

class homeBrainTests: XCTestCase {
    
    var managedObjectContext : NSManagedObjectContext?
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        managedObjectContext = setUpInMemoryManagedObjectContext()
        let neuralNetwork = NSEntityDescription.insertNewObject(forEntityName: "HBNeuralNetwork", into: managedObjectContext!) as! HBNeuralNetwork
        neuralNetwork.name = "Test"
        neuralNetwork.learningRate = 0.7
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HBNeuralNetwork")
        request.predicate = NSPredicate(format: "name==%@", "Test")
        do{
            let result = try managedObjectContext?.fetch(request)
            if(result?.count == 1){
                let net = result?[0] as! HBNeuralNetwork
                XCTAssert(net.learningRate == 0.7, "Network was created successfully")
            }
        } catch {
            print("Couldn't load neural networks")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
