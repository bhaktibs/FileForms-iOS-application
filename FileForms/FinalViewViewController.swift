//
//  FinalViewViewController.swift
//  FileForms
//
//  Created by bhakti shah on 4/10/17.
//  Copyright © 2017 bhakti shah. All rights reserved.
//

import UIKit
import PSPDFKit
import Messages

class FinalViewViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    var data=[String]()
    var document=PSPDFDocument()
    var identifier=""
    var userDefaults = UserDefaults.standard
   
    @IBAction func SendEmail(_ sender: Any) {
        if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            
            //Set the subject and message of the email
            mailComposer.setSubject("Relocation Form")
            mailComposer.setMessageBody("Please print the form", isHTML: false)
            
            if let filePath = Bundle.main.path(forResource: "Moving Expense", ofType: "pdf") {
                print("File path loaded.")
                
                if let fileData = NSData(contentsOfFile: filePath) {
                    print("File data loaded.")
                    mailComposer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "Moving Expense")
                }
            }
            self.present(mailComposer, animated: true, completion: nil)
        }
        
    }
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismiss(animated: true, completion: nil)
    }
 

    func intiate_pdf_object()
    {
        let fileURL = Bundle.main.bundleURL.appendingPathComponent("Moving Expense.pdf")
         document = PSPDFDocument(url: fileURL)
        let configuration = PSPDFConfiguration { builder in
            builder.thumbnailBarMode = .scrollable
            
        }
        let pdfController = PSPDFViewController(document: document, configuration: configuration)
        
        present(UINavigationController(rootViewController: pdfController), animated: true)
    }
    func showPDF()
    {
  var data_retrived = userDefaults.array(forKey: "userinput")
        let fields = document.formParser?.formFields
        let count = data_retrived?.count
        var c=0
        for f in fields!
        {
            if(c < count!)
            {
                f.value = data_retrived?[c]
                c += 1
            }
            else{
                f.value = "0"
                print(f.value ?? 0)
            }
        }

    }
    func populate_data()
    {
        let fields = document.formParser?.formFields
        let count = self.data.count
        var c=0
        for f in fields!
        {
            if(c < count)
            {
                f.value = self.data[c]
                c += 1
            }
            else{
                f.value = "0"
                print(f.value ?? 0)
            }
        }
        userDefaults.set(data, forKey: "userinput")
        userDefaults.synchronize()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        intiate_pdf_object()
        if(self.identifier=="show")
        {
        print(self.data)
        populate_data()
        }
        else if(self.identifier=="finalPage"){
            print("i am printing 2nd view",self.data)
            self.showPDF()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
