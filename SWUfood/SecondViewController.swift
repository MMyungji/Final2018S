//
//  SecondViewController.swift
//  SWU_food
//
//  Created by SWUCOMPUTER on 2018. 6. 16..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//
import CoreData
import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var textName: UITextField!
    @IBOutlet var textDescription: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var buttonCamera: UIButton!
    
    @IBOutlet var shopLabel: UILabel!
    
    var shop:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if !(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let alert = UIAlertController(title: "Error!!", message: "Device has no Camera!",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            buttonCamera.isEnabled = false // 카메라 버튼 사용을 금지시킴
        }
        
        if let content = shop{
            shopLabel.text = content
        }
        
    }

    //Core Data저장
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textDescription.becomeFirstResponder()
        return true
    }
      
    
    @IBAction func selectPicture (_ sender: UIButton) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
    }
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePicture (_ sender: UIButton) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.allowsEditing = true
        myPicker.sourceType = .camera
        self.present(myPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveDIY (_ sender: UIButton) {
        
        
        //Core data 저장
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "DIYfood", in: context)
        // friend record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(shop, forKey: "store_name")
        object.setValue(textName.text, forKey: "title")
        object.setValue(textDescription.text, forKey: "descript")
        object.setValue(Date(), forKey: "date")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)") }
        
        
        let name = textName.text!
        let description = textDescription.text!
        
        if (name == "" || description == "") {
            let alert = UIAlertController(title: "제목/설명을 입력하세요",
                                          message: "Save Failed!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil) }))
            self.present(alert, animated: true)
            return }
        
        guard let myImage = imageView.image else {
            let alert = UIAlertController(title: "이미지를 선택하세요",
                                          message: "Save Failed!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                            alert.dismiss(animated: true, completion: nil) }))
            self.present(alert, animated: true)
            return }
        
        let myUrl = URL(string: "http://condi.swu.ac.kr/student/W10iphone/DIY/upload.php");
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "POST";
        
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)",forHTTPHeaderField: "Content-Type")
        guard let imageData = UIImageJPEGRepresentation(myImage, 1) else { return }
        
        var body = Data()
        var dataString = "--\(boundary)\r\n"
        dataString += "Content-Disposition: form-data; name=\"userfile\";filename=\".jpg\"\r\n"
        dataString += "Content-Type: application/octet-stream\r\n\r\n"
        if let data = dataString.data(using: .utf8) { body.append(data) }
        // imageData 위 아래로 boundary 정보 추가
        body.append(imageData)
        dataString = "\r\n"
        dataString += "--\(boundary)--\r\n"
        if let data = dataString.data(using: .utf8) { body.append(data) }
        request.httpBody = body
        var imageFileName: String = ""
        let semaphore = DispatchSemaphore(value: 0)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return; }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { // 서버에 저장한 이미지 파일 이름
                imageFileName = utf8Data
                print(imageFileName)
                semaphore.signal()
            } }
        task.resume()
        // 이미지 파일 이름을 서버로 부터 받은 후 해당 이름을 DB에 저장하기 위해 wait()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        let urlString: String = "http://condi.swu.ac.kr/student/W10iphone/DIY/insertDIY.php"
        guard let requestURL = URL(string: urlString) else { return }
        request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.userName else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myDate = formatter.string(from: Date())
        
        var restString: String = "userid=" + userID + "&title=" + name
        restString += "&store_name="+shop!
        restString += "&description=" + description
        restString += "&image=" + imageFileName + "&date=" + myDate
        request.httpBody = restString.data(using: .utf8)
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { return }
            guard let receivedData = responseData else { return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
        }
        task2.resume()
        
        _ = self.navigationController?.popViewController(animated: true)
    
        
    }
        
    override func didReceiveMemoryWarning()
    {
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
