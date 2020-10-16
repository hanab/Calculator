//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Hana  Demas on 10/15/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    //MARK: properties
    var calculatorController:CalculatorViewController!
    
    //MARK: methods
    override func setUpWithError() throws {
        calculatorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "calculator") as? CalculatorViewController
        calculatorController?.loadView()
        calculatorController.viewDidLoad()
    }
    
    //MARK: TestCases
    func testTableViewExists() {
        XCTAssertNotNil(calculatorController?.historyTableView)
    }
    
    func testLabelExists() {
        XCTAssertNotNil(calculatorController?.resultLabel)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(calculatorController.historyTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(calculatorController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(calculatorController.responds(to: #selector(calculatorController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(calculatorController.responds(to: #selector(calculatorController.tableView(_:cellForRowAt:))))
    }
}
