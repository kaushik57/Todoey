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
     var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item ()
        newItem.title = "Hi you"
        itemArray.append(newItem)
        
        let newItem1 = Item ()
        newItem1.title = "How you doing"
        itemArray.append(newItem1)
        
        let newItem2 = Item ()
        newItem2.title = "Friends"
        itemArray.append(newItem2)
        // Do any additional setup after loading the view, typically from a nib.
    if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK - tABLEVIEW dATATSOURCE Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        
        cell.accessoryType  = item.done ?  .checkmark : .none
        
        return cell
    }
   // MARK- TABLEVIEW Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print (itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
       tableView .reloadData()
        
    tableView.deselectRow (at :indexPath, animated :true ) 
    }
    
    
    ///MARK - ADD NEW ITEMS
    
    
    @IBAction func TodoButtonPress(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
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
    

