//
//  DetailViewController.swift
//  SWU_food
//
//  Created by SWUCOMPUTER on 2018. 6. 20..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var textTitle: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var goodCount: UILabel!
    @IBOutlet var textDate: UILabel!
    @IBOutlet var textDescription: UILabel!
    @IBOutlet var imageView: UIImageView!
    // 상위 View에서 자료를 넘겨 받기 위한 변수
    var selectedData: DIYData?
    
    
    @IBOutlet var deleteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let DIYData = selectedData else { return }
        textTitle.text = DIYData.title
        nameLabel.text = "[ " + DIYData.userid + " ]"
        goodCount.text = DIYData.good + "개"
        textDate.text = DIYData.date
        textDescription.numberOfLines = 0
        textDescription.text = DIYData.descript
       
        
        var imageName = DIYData.image
        
        if (imageName != "") {
            let urlString = "http://condi.swu.ac.kr/student/W10iphone/DIY"
            imageName = urlString + imageName
            let url = URL(string: imageName)!
            if let imageData = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: imageData)
            } }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.userName else { return }
        
        deleteView.isHidden = true
        if userID == DIYData.userid {
            deleteView.isHidden = false
        }
        
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonDelete() {
        let alert=UIAlertController(title:"정말 삭제 하시겠습니까?", message: "",preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .cancel, handler: { action in
            let urlString: String = "http://condi.swu.ac.kr/student/W10iphone/DIY/deleteDIY.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            guard let foodNO = self.selectedData?.foodno else { return }
            let restString: String = "food_no=" + foodNO
            request.httpBody = restString.data(using: .utf8)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else { return }
                guard let receivedData = responseData else { return }
                if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
            }
            
            task.resume()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func likeButton(_ sender: UIButton) {
        selectedData?.good = String(Int((selectedData?.good)!)!+1)
        goodCount.text = (selectedData?.good)! + "개"
        
        let urlString: String = "http://condi.swu.ac.kr/student/W10iphone/DIY/updateGood.php"
        guard let requestURL = URL(string: urlString) else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        guard let foodNo = self.selectedData?.foodno else { return }
        guard let good = self.selectedData?.good else { return }
        
        let restString: String = "food_no="+foodNo+"&good_counts=" + good
        request.httpBody = restString.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else { return }
            guard let receivedData = responseData else { return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
        }
        task.resume()
      
        
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
