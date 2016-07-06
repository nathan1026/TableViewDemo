//
//  TableViewController.swift
//  TableViewDemo
//
//  Created by Nathan Bahl on 7/4/16.
//  Copyright © 2016 Nathan Bahl. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items = [DataItem]()
    
    var otherItems = [DataItem]()
    
    var allItems = [[DataItem]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation button to edit cells
        navigationItem.rightBarButtonItem = editButtonItem()

        
        //This iterates through all of the images using the DataItem class. Adds them to the items array.
        
        for i in 1...12{
            if i > 9 {
                items.append(DataItem(title: "Title # \(i)", subtitle: "This is subtitle #\(i)", imageName: "images/img\(i).jpg"))
                
            } else {
                items.append(DataItem(title: "Title #0\(i)", subtitle: "This is subtitle #0\(i)", imageName: "images/img0\(i).jpg"))
            }
        }
        
        
        for i in 1...12 {
            if i > 9{
                otherItems.append(DataItem(title: "Another title #\(i)", subtitle: "This is another subtitle #\(i)", imageName: "images/anim\(i).jpg"))
            } else {
                otherItems.append(DataItem(title: "Another title #0\(i)", subtitle: "This is another subtitle #0\(i)", imageName: "images/anim0\(i).jpg"))
            }
            
        }
    
        allItems.append(items)
        allItems.append(otherItems)

        
        //Add new item to table
        tableView.allowsSelectionDuringEditing = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return allItems.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let addedRow = editing ? 1 : 0
        
        return allItems[section].count + addedRow
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        //If there are more rows(because of adding edited row) then it generates a label for that new row
        if indexPath.row >= allItems[indexPath.section].count && editing {
            cell.textLabel?.text = "Add New Item"
            cell.detailTextLabel?.text = nil
            cell.imageView?.image = nil
            
        } else {
        
        let item = allItems[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
    
        if let imageView = cell.imageView, itemImage = item.image {
            imageView.image = itemImage
            
        } else {
            cell.imageView?.image = nil
            }
        }
        return cell
    }
    
   
   
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section #\(section)"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    //Checking to see if editing or deleting row
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        let sectionItems = allItems[indexPath.section]
        
        if indexPath.row >= sectionItems.count {
            return .Insert
        } else {
            return .Delete
        }
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            allItems[indexPath.section].removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            let newData = DataItem(title: "New Item", subtitle: "", imageName: nil)
            allItems[indexPath.section].append(newData)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            tableView.beginUpdates()
            
            for (index, sectionItems) in allItems.enumerate() {
                let indexPath = NSIndexPath(forRow: sectionItems.count, inSection: index)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            tableView.endUpdates()
            tableView.setEditing(true, animated: true)
            
        } else {
            
            tableView.beginUpdates()
            
            for (index, sectionItems) in allItems.enumerate() {
                let indexPath = NSIndexPath(forRow: sectionItems.count, inSection: index)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            }
            tableView.endUpdates()
            tableView.setEditing(false, animated: true)
            
        }
        
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let sectionItems = allItems[indexPath.section]
        if editing && indexPath.row < sectionItems.count {
            return nil
        }
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let sectionItems = allItems[indexPath.section]
        if indexPath.row >= sectionItems.count && editing {
            self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
            
        }
        
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let sectionItems = allItems[indexPath.section]
        if indexPath.row >= sectionItems.count && editing {
            return false
        }
        
        return true
        
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var fromSectionItems = allItems[fromIndexPath.section]
        var toSectionItems = allItems[toIndexPath.section]
        let itemToMove = fromSectionItems[fromIndexPath.row]
        
        if fromIndexPath.section == toIndexPath.section {
            if toIndexPath.row != fromIndexPath.row {
                
                swap(&toSectionItems[toIndexPath.row], &toSectionItems[fromIndexPath.row])
            }
        } else {
            
            toSectionItems.insert(itemToMove, atIndex: toIndexPath.row)
            fromSectionItems.removeAtIndex(fromIndexPath.row)
        }
        
        
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        
        let sectionItems = allItems[proposedDestinationIndexPath.section]
        if proposedDestinationIndexPath.row >= sectionItems.count {
            
            return NSIndexPath(forItem: sectionItems.count - 1, inSection: proposedDestinationIndexPath.section)
        }
        
        return proposedDestinationIndexPath
    }

}
