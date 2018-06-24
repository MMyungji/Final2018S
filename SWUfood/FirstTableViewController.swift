//
//  FirstTableViewController.swift
//  SWU_food
//
//  Created by SWUCOMPUTER on 2018. 6. 16..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {

    let Store : [String] = ["비틀주스","가은","츄밥","퀴즈노스","기타"]
    var fetchedArray: [DIYData] = Array()
    
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        fetchedArray = []
        self.downloadDataFromServer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func downloadDataFromServer() -> Void {
        
        let urlString: String = "http://condi.swu.ac.kr/student/W10iphone/DIY/DIYTable.php"
        guard let requestURL = URL(string: urlString) else { return }
        let request = URLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else {
                print("Error: not receiving Data"); return; }
            let response = response as! HTTPURLResponse
            
            if !(200...299 ~= response.statusCode) { print("HTTP response Error!"); return }
            do {
                if let jsonData = try JSONSerialization.jsonObject (with: receivedData,
                                                                    options:.allowFragments) as? [[String: Any]] {
                    
                    for i in 0...jsonData.count-1 {
                        let newData: DIYData = DIYData()
                        
                        
                        var jsonElement = jsonData[i]
                        newData.foodno = jsonElement["food_no"] as! String
                        newData.userid = jsonElement["userid"] as! String
                        newData.title = jsonElement["title"] as! String
                        newData.store = jsonElement["store_name"] as! String
                        newData.descript = jsonElement["description"] as! String
                        newData.image = jsonElement["image"] as! String
                        newData.date = jsonElement["date"] as! String
                        newData.good = jsonElement["good_counts"] as! String
                        
                        self.fetchedArray.append(newData)
                    }
                    DispatchQueue.main.async { self.tableView.reloadData() } }
            } catch { print("Error:") } }
        task.resume() }
    
    @IBAction func calendar(_ sender: UIBarButtonItem) {
        fetchedArray = []
        
        let urlString: String = "http://condi.swu.ac.kr/student/W10iphone/DIY/DIYTable.php"
        guard let requestURL = URL(string: urlString) else { return }
        let request = URLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else {
                print("Error: not receiving Data"); return; }
            let response = response as! HTTPURLResponse
            
            if !(200...299 ~= response.statusCode) { print("HTTP response Error!"); return }
            do {
                if let jsonData = try JSONSerialization.jsonObject (with: receivedData,
                                                                    options:.allowFragments) as? [[String: Any]] {
                    
                    for i in 0...jsonData.count-1 {
                        let newData: DIYData = DIYData()
                        
                        
                        var jsonElement = jsonData[i]
                        newData.foodno = jsonElement["food_no"] as! String
                        newData.userid = jsonElement["userid"] as! String
                        newData.title = jsonElement["title"] as! String
                        newData.store = jsonElement["store_name"] as! String
                        newData.descript = jsonElement["description"] as! String
                        newData.image = jsonElement["image"] as! String
                        newData.date = jsonElement["date"] as! String
                        newData.good = jsonElement["good_counts"] as! String
                        
                        self.fetchedArray.append(newData)
                    }
                    DispatchQueue.main.async { self.tableView.reloadData() } }
            } catch { print("Error:") } }
        task.resume()
    }
    
    @IBAction func likeButton(_ sender: UIBarButtonItem) {
        
        fetchedArray = []
        
        let urlString: String = "http://condi.swu.ac.kr/student/W10iphone/DIY/DIYTable2.php"
        guard let requestURL = URL(string: urlString) else { return }
        let request = URLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else {
                print("Error: not receiving Data"); return; }
            let response = response as! HTTPURLResponse
            
            if !(200...299 ~= response.statusCode) { print("HTTP response Error!"); return }
            do {
                if let jsonData = try JSONSerialization.jsonObject (with: receivedData,
                                                                    options:.allowFragments) as? [[String: Any]] {
                    
                    for i in 0...jsonData.count-1 {
                        let newData: DIYData = DIYData()
                        
                        
                        var jsonElement = jsonData[i]
                        newData.foodno = jsonElement["food_no"] as! String
                        newData.userid = jsonElement["userid"] as! String
                        newData.title = jsonElement["title"] as! String
                        newData.store = jsonElement["store_name"] as! String
                        newData.descript = jsonElement["description"] as! String
                        newData.image = jsonElement["image"] as! String
                        newData.date = jsonElement["date"] as! String
                        newData.good = jsonElement["good_counts"] as! String
                        
                        self.fetchedArray.append(newData)
                    }
                    DispatchQueue.main.async { self.tableView.reloadData() } }
            } catch { print("Error:") } }
        task.resume()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Store.count
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedArray.count
    }

    //헤더
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Store[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DIY Cell", for: indexPath)

        // Configure the cell...
        
        let item = fetchedArray[indexPath.row]
        if item.store == "비틀주스"{
            
        }
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.userid + "   " + item.store + "                              좋아요 " + item.good + "개"
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    let data = fetchedArray[selectedIndex]
                    destination.selectedData = data
                   
                } }
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
