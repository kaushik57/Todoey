//
//  ViewController.swift
//  Todoey
//
//  Created by Vuesol on 11/29/18.
//  Copyright © 2018 Vuesol. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

     var defaults = UserDefaults.standard
     var itemArray = ["hi you" , "how you doing", "dragons"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }

    //MARK - tABLEVIEW dATATSOURCE Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
         cell.textLabel?.text = itemArray[indexPath.row]
        
        
        return cell
    }
   // MARK- TABLEVIEW Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print (itemArray[indexPath.row])
        if (tableView.cellForRow (at :indexPath)?.accessoryType == .checkmark) {
           tableView.cellForRow (at :indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow (at :indexPath)?.accessoryType = .checkmark
        }
        
    tableView.deselectRow (at :indexPath, animated :true ) 
    }
    
    
    ///MARK - ADD NEW ITEMS
    
    
    @IBAction func TodoButtonPress(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
           self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (  alerttextField) in
           alerttextField.placeholder = "create new item"
            textField = alerttextField
            
        }
        alert.addAction(action)
        present(alert, animated:  true, completion: nil)
        
    }
    
}
    

   
