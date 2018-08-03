//
//  PDetailViewController.swift
//  HajHack
//
//  Created by Dalal on 8/1/18.
//  Copyright © 2018 Dalal. All rights reserved.
//

import UIKit
import Alamofire

class PDetailViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate{

    @IBOutlet weak var toplayout: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var pname: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var periodButton: UIView!
    @IBOutlet weak var addButtonBackg: UIView!
    @IBOutlet weak var newMessage: UITextView!
    @IBOutlet weak var sendTextMessage: UIButton!
    @IBOutlet weak var messsagesTable: UICollectionView!
    var missingP = MissingPilgrimage()
    var messagesArray  = [MessageUpdate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newMessage.delegate = self
        self.pname.text = missingP.name
        self.avatar.image = missingP.image
        self.period.text = missingP.period
        if let messges = self.missingP.informationHistory{
            self.messagesArray = messges
        }
        
        
        
        messsagesTable.delegate = self
        messsagesTable.dataSource = self
        backgroundView.layer.cornerRadius = backgroundView.bounds.size.height/2;
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor
        backgroundView.layer.borderWidth = 1.0;
        
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.clear.cgColor
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        

        
        periodButton.layer.cornerRadius = periodButton.bounds.size.height/7;
        
        addButtonBackg.layer.cornerRadius = periodButton.bounds.size.height/7;
        addButtonBackg.layer.borderColor = UIColor.lightGray.cgColor
        addButtonBackg.layer.borderWidth = 1.0;
        
        newMessage.layer.cornerRadius = periodButton.bounds.size.height/6;
        newMessage.layer.borderColor = UIColor.lightGray.cgColor
        newMessage.layer.borderWidth = 1.0;
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        toplayout.constant = 270
        
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        toplayout.constant = 535
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.messagesArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Missing", for: indexPath) as! UpdateCollectionViewCell
        
        
        cell.pligrimName.text = self.messagesArray[indexPath.row].name
        cell.avatar.image = self.messagesArray[indexPath.row].image
        cell.messgaeLabel.text = self.messagesArray[indexPath.row].message
        
        cell.date.text = self.messagesArray[indexPath.row].date
        cell.time.text = self.messagesArray[indexPath.row].time
        
        return cell
    }
    
    
    
    
    //    func listChildHandler(children:[MissingChild]?){
    //        if children?.count == 0 {
    //
    //        }else{
    //            self.children = children
    //            self.ListTableView.reloadData()
    //
    //        }
    //
    //
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messagesArray.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
   
        var url = "http://198.211.119.242/HajjConnect/users/reportlostinfo"
        
        let parameters: Parameters = [
            
                "beaconId": "dcabc717ed9e",
                "message":self.newMessage.text
            
        ]
        
        
        Alamofire.request(url, method: .post,parameters: parameters,  encoding: JSONEncoding.default,headers:["Content-Type": "application/json"])
            
            .responseJSON {[unowned self] response in
                print("Success0")
                switch response.result {
                case .success(let json):
                    print("Success1")
                    if let data = json as? [String: Any] {
                        print(data)
                        if let success =  data["response"] as? Int{
                            
                            if success == 1 {
                                print("Success3")
                                
                                
                            }else{
                                print("Errror0")
                                //completionHandler(Constants.RESPONSE_FAIL_STATUS_CODE,nil,data["message"] as! String )
                            }
                            
                            
                        }else {
                            print("Errror1")
                            //                                completionHandler(Constants.RESPONSE_FAIL_STATUS_CODE,nil,data["message"] as! String)
                            
                        }
                        
                        
                    }
                    
                    
                case .failure(let err):
                    
                    print(err)
                }
                
        }
    
    }
    
}
