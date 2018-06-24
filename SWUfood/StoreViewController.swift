//
//  StoreViewController.swift
//  SWU_food
//
//  Created by SWUCOMPUTER on 2018. 6. 20..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet var shopLabel: UILabel!
    var shop:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let content=shop{
            shopLabel.text = content
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditView" {
            let destVC = segue.destination as! SecondViewController
            
            let button = sender as! UIButton
            let ordered: String! = button.titleLabel?.text
            
            destVC.title = ordered
            destVC.shop = shop
        } }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
