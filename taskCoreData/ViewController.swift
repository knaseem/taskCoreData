//
//  ViewController.swift
//  taskCoreData
//
//  Created by naseem on 11/08/2016.
//  Copyright © 2016 naseem. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let managedObjectContext =
        (UIApplication.sharedApplication().delegate
            as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var showLabel: UILabel!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        let entityDescription =
            NSEntityDescription.entityForName("Contacts",
                                              inManagedObjectContext: managedObjectContext)
        
        let contact = Contacts(entity: entityDescription!,
                               insertIntoManagedObjectContext: managedObjectContext)
        
        contact.name = textField.text!
        
        
        do {
            try managedObjectContext.save()
            textField.text = ""
            
        } catch {
            print("Error Saving)")
        }
        
    }
    @IBAction func showButtonTapped(sender: AnyObject) {
        
        let entityDescription =
            NSEntityDescription.entityForName("Contacts",
                                              inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(name = %@)", textField.text!)
        request.predicate = pred
        
        
        do {
            var results =
                try managedObjectContext.executeFetchRequest(request)
            

            if results.count > 0 {
               let match = results[0] as! NSManagedObject
                textField.text = match.valueForKey("name") as? String
                showLabel.text = "Matches found: \(results.count)"
                
            } else {
                showLabel.text = "No Match"
            }
            
        } catch let error as NSError {
            showLabel.text = error.localizedFailureReason
        }
    }
    
    
} // End of ViewController Class

