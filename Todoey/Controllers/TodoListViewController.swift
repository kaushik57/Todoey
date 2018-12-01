//
//  ViewController.swift
//  Todoey
//
//  Created by Vuesol on 11/29/18.
//  Copyright © 2018 Vuesol. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
@available(iOS 10.0, *)
class TodoListViewController: UITableViewController {

    
     var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
       
       print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        
       
        // Do any additional setup after loading the view, typically from a nib.
 //   if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        //    itemArray = items
      //  }
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
       
     //   itemArray[indexPath.row].setValue("Completed", forKey: "title")
      
        
      //  context.delete(itemArray[indexPath.row])
      //  itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
        saveItems()
        
        tableView .reloadData()
        
    tableView.deselectRow (at :indexPath, animated :true ) 
    }
    
    
    ///MARK - ADD NEW ITEMS
    
    
    @IBAction func TodoButtonPress(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
           
          
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
           
            self.saveItems()
            
        }
        alert.addTextField { (  alerttextField) in
           alerttextField.placeholder = "create new item"
            textField = alerttextField
            
        }
        alert.addAction(action)
        present(alert, animated:  true, completion: nil)
    
        
        
    }
    func saveItems () {
        
        do {
          try context.save()
        } catch {
          print("Error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }

    func loadItems( with request: NSFetchRequest <Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@ ", selectedCategory!.name!)
        let compundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        request.predicate = compundPredicate
        let request :NSFetchRequest<Item> = Item.fetchRequest()
        do {
            
       itemArray =   try context.fetch(request)
        } catch {
            print ("Error fetching data from context \(error)")
        }
        
    }
    
    
}
@available(iOS 10.0, *)
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
       let predicate = NSPredicate(format: "title Contains [cd] %@", searchBar.text!)
      
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate )
     //   do {
            
       //     itemArray =   try context.fetch(request)
       // } catch {
         //   print ("Error fetching data from context \(error)")
       // }
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                
            searchBar.resignFirstResponder()
            }
    
        }
    }
}


