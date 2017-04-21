//
//  FileFormsTests.swift
//  FileFormsTests
//
//  Created by bhakti shah on 4/11/17.
//  Copyright © 2017 bhakti shah. All rights reserved.
//

import XCTest
@testable import FileForms
class FileFormsTests: XCTestCase {
    
    //To test if the SecondViewController has the tableView or not.
    func test_Second_ViewController()
    {
        let vc = SecondViewControllerTableViewController()
        _ = vc.view
        XCTAssertNotNil(vc.tableView)
    }
    
    //To test if the ViewController has active buttons or not
    func test_viewController_buttons(){
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        _ = vc.view
        XCTAssertNotNil(vc.button)
        XCTAssertNotNil(vc.ReviewButton)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
