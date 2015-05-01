//
//  BankDetailView.swift
//  Bankwijzer
//
//  Created by Fhict on 30/04/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import UIKit

class BankDetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var values = ["Klimaatverandering", "Mensenrechten", "Arbeidsrechten", "Wapens", "Dierenwelzijn", "Natuur", "Bonussen", "Gezondheid", "Belasting en corruptie", "Transparantie", "Landbouw", "Dammen", "Visserij", "Bosbouw", "Mijnbouw", "Olie en gas", "Maakindustrie", "Financiele sector", "Woning en vastgoed", "Vermogensbeheer"]
    var percent = [85, 70, 58, 50, 40, 65, 60, 30, 25, 15, 98, 85, 70, 58, 50, 40, 65, 60, 30, 25, 15, 98]
    
    let textCellIdentifier = "bankDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set delegate and datasource to self to override functions
        table.delegate = self
        table.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        
        // Add text to cellrow
        cell.textLabel?.text = values[row]
        cell.textLabel?.font = UIFont.systemFontOfSize(24.0)
        
        // Draw back gray bar in cellrow
        var barBack = UIView(frame: CGRectMake(300, 10, 400, 40));
        barBack.backgroundColor = UIColor.lightGrayColor()
        cell.addSubview(barBack)
        
        // Draw coloured overlay in celrow
        var p = CGFloat(percent[row] * 4)
        var barFront = UIView(frame: CGRectMake(300, 10, p, 40));
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
        println(values[row])
    }
}
