//
//  MyDetailViewController.swift
//  SWUfood
//
//  Created by SWUCOMPUTER on 2018. 6. 24..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class MyDetailViewController: UIViewController {

    
    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    var detailFood: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let food = detailFood {
            titleLabel.text = food.value(forKey: "title") as? String
            descriptLabel.text = food.value(forKey: "descript") as? String
            storeLabel.text = food.value(forKey: "store_name") as? String
            let dbDate: Date? = food.value(forKey: "date") as? Date
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd h:mm a"
            if let unwrapDate = dbDate {
                let displayDate = formatter.string(from: unwrapDate as Date)
                dateLabel.text = displayDate }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
