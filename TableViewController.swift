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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return allItems.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allItems[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let item = allItems[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.detailTextLabel?.text = item.subtitle
        
        if let imageView = cell.imageView, itemImage = item.image {
            imageView.image = itemImage
            
        } else {
            
            cell.imageView?.image = nil
            
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

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
