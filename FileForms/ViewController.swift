//
//  ViewController.swift
//  FileForms
//
//  Created by bhakti shah on 4/10/17.
//  Copyright © 2017 bhakti shah. All rights reserved.
//

import UIKit
import PSPDFKit

class ViewController: UIViewController {
  
    
    @IBOutlet weak var Myforms: UILabel!
    @IBOutlet weak var ReviewButton: UIButton!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
                let controller = segue.destination as! FinalViewViewController
                controller.identifier="showDetail"
            }
        else if segue.identifier == "firstPage"
        {
            let controller=segue.destination as! SecondViewControllerTableViewController
        }
        }
  
   

}

