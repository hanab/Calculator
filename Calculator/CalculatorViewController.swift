//
//  ViewController.swift
//  Calculator
//
//  Created by Hana  Demas on 10/15/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit
import CoreData

class CalculatorViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var historyTableView: UITableView!
    
    fileprivate let cellId = "cell"
    var history: [NSManagedObject] = []
    
    var numerOnScreen = 0.0
    var lhs = 0.0
    var isOperation = false
    var operation = 0
    
    //MARK: lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.backgroundColor = UIColor.black
        historyTableView.separatorColor = UIColor.white
        historyTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetch()
    }
    
    //MARK: private methods
    private func getHistoryText(operation: String) -> String {
        return "\(lhs)" + " \(operation) \(numerOnScreen)" + (" = " + resultLabel.text!)
    }
    
    private func displayOperators(tag: Int) {
        switch (tag) {
        case 12: //divde
            resultLabel.text = "/"
        case 13: //multiply
            resultLabel.text = "*"
        case 14://subtract
            resultLabel.text = "-"
        case 15: //add
            resultLabel.text = "+"
        case 17://remainder
            resultLabel.text = "%"
        default:
            print("unkown operation")
        }
    }
    
    private func performOperation(operation: Int) ->String {
        var historyEntry = ""
        
        switch (operation) {
        case 12: //divde
            resultLabel.text = "\(lhs / numerOnScreen)"
            historyEntry += getHistoryText(operation: "/")
        case 13: //multiply
             resultLabel.text = "\(lhs * numerOnScreen)"
             historyEntry += getHistoryText(operation: "*")
        case 14://subtract
             resultLabel.text = "\(lhs - numerOnScreen)"
             historyEntry += getHistoryText(operation: "-")
        case 15: //add
            resultLabel.text = "\(lhs + numerOnScreen)"
            historyEntry += getHistoryText(operation: "+")
        case 17://remainder
            resultLabel.text = "\(lhs.truncatingRemainder(dividingBy: numerOnScreen))"
            historyEntry += getHistoryText(operation: "+")
        default:
            print("unkown operation")
        }
        
        return historyEntry
    }
    
    private func reset() {
        resultLabel.text = "0"
        lhs = 0
        numerOnScreen = 0
        operation = 0
    }
    
    //MARK: Button Actions
    @IBAction func keyPressed(_ sender: Any) {
        
        if(isOperation) {
            resultLabel.text = "\((sender as AnyObject).tag - 1)"
            numerOnScreen = Double(resultLabel.text!) ?? 0
            isOperation = false
        } else {
            
            if (resultLabel.text == "0") || operation == 16 {
                resultLabel.text = "\((sender as AnyObject).tag - 1)"
                operation = 0
            } else {
                resultLabel.text = resultLabel.text! + "\((sender as AnyObject).tag - 1)"
            }
            numerOnScreen = Double(resultLabel.text!) ?? 0
        }
    }
    
    @IBAction func OperationsPressed(_ sender: Any) {
        
        if resultLabel.text != "" && (sender as AnyObject).tag != 11 && (sender as AnyObject).tag != 16  && (sender as AnyObject).tag != 18 {
            lhs = Double(resultLabel.text!) ?? 0
            
            displayOperators(tag: (sender as AnyObject).tag)
            
            isOperation = true
            operation = (sender as AnyObject).tag
        } else if (sender as AnyObject).tag == 16 {
            let historyEntry = performOperation(operation: operation)
            
            operation = 16
            if(historyEntry != "") {
                self.save(history: historyEntry)
                historyTableView.reloadData()
            }
        
        } else if (sender as AnyObject).tag == 11 {
            reset()
        } else if (sender as AnyObject).tag == 18 {
            let number = -1 * (Double(resultLabel.text!) ?? 0)
            resultLabel.text = "\(number)"
            numerOnScreen = number
        }
    }
}

//MARK: Extension for implementing datasource and delegate
extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate  {
    
    //MARK: tableview datasource
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count <= 10 ? history.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let entry = history[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.black
        cell.textLabel?.text = entry.value(forKeyPath: "historyEntry") as? String
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
}
