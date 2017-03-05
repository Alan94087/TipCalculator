//
//  ViewController.swift
//  TipView
//
//  Created by Alan Hantke on 3/4/17.
//  Copyright © 2017 Alan Hantke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var friendField: UITextField!
    @IBOutlet weak var friendTotal: UILabel!
    @IBOutlet weak var friendView: UIView!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        // This actually isn't working the way I expected... I thought the event would
        // be triggered each time the app came into focus.  In that event, if one were to
        // change the Setting value for the visibility of the friend view, the friend view
        // would follow the setting.  However, that doesn't seem to be the case...  
        // Unfortunately I have a commitment that prevents me from investigaing further.
        super.viewWillAppear(animated)
        friendView.isHidden = !userDefaults.bool(forKey: "enabled_preference")
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
      //  friendView.isHidden = !userDefaults.bool(forKey: "enabled_preference")

        let tipPercentages = [0.15, 0.18, 0.2]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip

        // OK, this isn't any good. It should only  take an integer.  But the
        // point of this class is to learn how to properly use delegates and
        // to restrict data as desired.  I could all use a scroll box, I suppose.
        
        print("friendField: " + (friendField.text ?? "none"))
        let friendCount = Int(friendField.text!) ?? 2
        print(friendCount)
        // Add $0.01 to each friend to be fair and to not short change the vendor
        let friendValue = Double(((total / Double(friendCount)) + 0.01))
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        friendTotal.text = String(format: "$%.2f", friendValue)

    }
    @IBAction func valueChange(_ sender: Any) {
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
}

