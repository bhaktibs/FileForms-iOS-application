//
//  SecondViewControllerTableViewController.swift
//  FileForms
//
//  Created by bhakti shah on 4/10/17.
//  Copyright © 2017 bhakti shah. All rights reserved.
//

import UIKit
import PSPDFKit
class FruitTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var mylabel: UILabel!

    @IBOutlet weak var userinput: UITextField!
}

class SecondViewControllerTableViewController: UITableViewController,UITextFieldDelegate {
    
@IBOutlet weak var submit: UIButton!
var list=[String]()
var rowBeingEdited : Int? = nil
var arrayOfNames : [String] = [String]()


    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "Moving Expense", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    for key in object.keys.sorted() {
                        let value = object[key]
                        list.append(value as! String)
                        // access all key / value pairs in dictionary
                    }
                    print(object)
                    print(list)
                }
                    
                else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //submit.isEnabled=false
        readJson()
        for _ in list
        {
            arrayOfNames.append("")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    var selectedRowIndex = -1
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex {
            return 150 //Expanded
        }
        return 40 //Not expanded
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1
        } else {
            selectedRowIndex = indexPath.row
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FruitTableViewCell
        
        cell.title.text = "Question:"+String(indexPath.row)
        //cell.mylabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.userinput.text = arrayOfNames[indexPath.row] // just in case cells are re-used, this clears the old value
        cell.userinput.tag = indexPath.row
        cell.mylabel.text = list[indexPath.row]
        cell.mylabel.numberOfLines=0
        cell.userinput.delegate=self
        cell.userinput.placeholder="Enter you Answer"
       
        return cell
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       // print("i am called")
        return UITableViewAutomaticDimension
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let row = textField.tag
        if row >= arrayOfNames.count {
            for _ in stride(from: arrayOfNames.count, to: row, by: 1)
            {
                arrayOfNames.append("") // this adds blank rows in case the user skips rows
            }
        }
        arrayOfNames[row]=textField.text!
        rowBeingEdited = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        rowBeingEdited = textField.tag
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            //if let indexPath = self.tableView.indexPathForSelectedRow {
            self.view .endEditing(true)
                let controller = segue.destination as! FinalViewViewController
                controller.data = arrayOfNames
            controller.identifier="show"
            print(arrayOfNames)
        }
        }
    }

