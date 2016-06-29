//
//  TableViewController.swift
//  OlimDemo
//
//  Created by Argela on 28/06/16.
//  Copyright © 2016 olim. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let urlArray = ["http://www.hurses.com.tr/resimler/04-2016/27-04-2016-09-46-23erdogan.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/27-04-2016-06-11-12davutoglu_.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/27-04-2016-06-11-12davutoglu_.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/27-04-2016-06-11-14davutoglu_.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/29-04-2016-21-41-43soner_canko.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/27-04-2016-08-55-18bursa_.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/29-04-2016-06-09-11suriye.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/28-04-2016-14-10-15Tayyip_Erdogan.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/24-04-2016-00-16-46davutoglu.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/23-04-2016-11-48-39davutoglu_markel.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/29-04-2016-15-30-46cevdet_yilmaz_.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/16-04-2016-08-11-12chp.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/09-04-2016-09-28-59umit_ozdag.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/08-04-2016-06-54-02MHP_logo.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/24-04-2016-06-53-35azad_fazla.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/29-04-2016-09-57-03beylikduzu_.jpg",
                    "http://www.hurses.com.tr/resimler/04-2016/29-04-2016-11-22-13halit_bilgin1_.jpg",
                    "http://www.hurses.com.tr/resimler/05-2016/30-04-2016-23-58-55bomba_gaziantep.jpg",
                    "http://www.hurses.com.tr/resimler/05-2016/30-04-2016-23-40-01sehit_nusaybin.jpg",
                    "http://www.hurses.com.tr/resimler/05-2016/30-04-2016-15-04-27senegal.jpg",
                    "http://www.hurses.com.tr/resimler/05-2016/30-04-2016-23-42-42kahvehane.jpg",
                    "http://www.hurses.com.tr/resimler/03-2016/29-03-2016-12-05-04RamiAslan_.jpg",
                    "http://www.hurses.com.tr/resimler/03-2016/21-03-2016-13-17-13iphone.jpg",
                    "http://www.hurses.com.tr/resimler/02-2016/11-02-2016-08-32-44havelsan_.jpg",
                    "http://www.hurses.com.tr/resimler/02-2016/09-02-2016-01-56-24binali_yildirim_.jpg",
                    "http://www.hurses.com.tr/resimler/03-2016/26-03-2016-12-25-34bimeks_sivas.jpg",
                    "http://www.hurses.com.tr/resimler/03-2016/12-03-2016-13-40-13NEUslanders.jpg",
                    "http://www.hurses.com.tr/resimler/02-2016/19-02-2016-03-00-07faceebok.jpg",
                    "http://www.hurses.com.tr/resimler/eski/27-01-2016-15-15-28vodafone.jpg",
                    "http://www.hurses.com.tr/resimler/eski/07-01-2016-10-40-06innova.jpg",
                    "http://www.hurses.com.tr/resimler/eski/07-01-2016-10-30-26casper.jpg",
                    "http://www.hurses.com.tr/resimler/eski/31-12-2015-12-21-04tekno.jpg",
                    "http://www.hurses.com.tr/resimler/eski/03-12-2015-15-18-13cep.jpg",
                    "http://www.hurses.com.tr/resimler/eski/22-11-2015-10-30-32vod.jpg",
                    "http://www.hurses.com.tr/resimler/eski/03-10-2015-12-10-53tek1.jpg",
                    "http://www.hurses.com.tr/resimler/eski/03-09-2015-10-43-26siber_1.jpg",
                    "http://www.hurses.com.tr/resimler/eski/06-2015/siber_2.jpg",
                    "http://www.hurses.com.tr/resimler/02-2016/halit_bilgin3-.jpg",
                    "http://www.hurses.com.tr/resimler/02-2016/halit_bilgin4-.jpg",
                    "http://www.hurses.com.tr/resimler/02-2016/halit_bilgin2-.jpg"];
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return urlArray.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath) as! TableViewCell;
        let index = indexPath.row;
        Olimpo.load(urlArray[index]).placeHolder(UIImage(named: "load")!).error(UIImage(named: "error")!).into(cell.sectionImageView);
        cell.sectionLabel.text = "Row number is \(index)";
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90;
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
