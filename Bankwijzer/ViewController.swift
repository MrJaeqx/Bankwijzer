//
//  ViewController.swift
//  Bankwijzer
//
//  Created by Fhict on 30/04/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var table: UITableView!
    
    var banks = ["ASN Bank", "SNS Bank", "NIBC", "Triodos Bank", "ABN AMRO", "AEGON", "ING", "Rabobank", "Delta Lloyd", "ING"]
    var percent = [85, 70, 65, 60, 58, 50, 40, 30, 25, 15, 98]

    let textCellIdentifier = "bankCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // add tap gesture recognizer to imageview
        image.userInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))

        // set delegate and datasource to self to override functions
        table.delegate = self
        table.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // called when image is tapped
    func handleTap(gestureRecognizer: UITapGestureRecognizer){
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("vragen")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    
    
    
    // UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        
        // Add text to cellrow
        cell.textLabel?.text = "Score: " + String(percent[row]) + "%"
        cell.textLabel?.font = UIFont.systemFontOfSize(24.0)
        
        // Add banklogo to cellrow
        cell.imageView?.image = UIImage(named: banks[row] + ".png")
        cell.imageView?.sizeToFit()
        
        // Draw back gray bar in cellrow
        var barBack = UIView(frame: CGRectMake(300, 25, 400, 50));
        barBack.backgroundColor = UIColor.lightGrayColor()
        cell.addSubview(barBack)
        
        // Draw coloured overlay in celrow
        var p = CGFloat(percent[row] * 4)
        var barFront = UIView(frame: CGRectMake(300, 25, p, 50));
        if(percent[row] < 30) {
            barFront.backgroundColor = UIColor.redColor()
        } else if (percent[row] < 60) {
            barFront.backgroundColor = UIColor.orangeColor()
        }
        else {
            barFront.backgroundColor = UIColor.greenColor()
        }
        cell.addSubview(barFront)
        
        
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(banks[row])
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("bankDetail")
        self.showViewController(vc as! UIViewController, sender: vc)

    }
}

