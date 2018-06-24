//
//  HomeViewController.swift
//  SWU_food
//
//  Created by SWUCOMPUTER on 2018. 6. 12..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var mostLikeLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    var im = [
        "im1.png","im2.png","im33.png"
    ]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            self.helloLabel.text = name + "님 환영합니다."
        }
        
        pageControl.numberOfPages = im.count
        pageControl.currentPage=0
        pageControl.pageIndicatorTintColor=UIColor.white
        pageControl.currentPageIndicatorTintColor=UIColor.green
        imgView.image=UIImage(named:im[0])
        
        
        if let menu = appDelegate.mostMenu{
            self.mostLikeLabel.text = menu
        }
        
    }

    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        imgView.image = UIImage(named:im[pageControl.currentPage])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStoreView1" {
            let destVC = segue.destination as! StoreViewController
            
            let button = sender as! UIButton
            let ordered: String! = button.titleLabel?.text
            
            destVC.title = ordered
            destVC.shop = ordered
        }
        if segue.identifier == "toStoreView2" {
            let destVC = segue.destination as! StoreViewController
            
            let button = sender as! UIButton
            let ordered: String! = button.titleLabel?.text
            
            destVC.title = ordered
            destVC.shop = ordered
        }
        if segue.identifier == "toStoreView3" {
            let destVC = segue.destination as! StoreViewController
            
            let button = sender as! UIButton
            let ordered: String! = button.titleLabel?.text
            
            destVC.title = ordered
            destVC.shop = ordered
        }
        if segue.identifier == "toStoreView4" {
            let destVC = segue.destination as! StoreViewController
            
            let button = sender as! UIButton
            let ordered: String! = button.titleLabel?.text
            
            destVC.title = ordered
            destVC.shop = ordered
        }
        if segue.identifier == "toStoreView5" {
            let destVC = segue.destination as! StoreViewController
            
            let button = sender as! UIButton
            let ordered: String! = button.titleLabel?.text
            
            destVC.title = ordered
            destVC.shop = ordered
        }
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
