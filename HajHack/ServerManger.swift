//
//  ServerManger.swift
//  HajHack
//
//  Created by Dalal on 8/2/18.
//  Copyright © 2018 Dalal. All rights reserved.
//

import Foundation

import Alamofire



class ServerManger {


    static let sharedInstance : ServerManger = {
        let instance = ServerManger()
        
        // Loading saved Data
        //        instance.loadSavedUserData()
        
        return instance
    }()
    
    
    func getalllosts(completionHandler: @escaping ( [MissingPilgrimage]?)  -> ()){
        var url = "http://198.211.119.242/HajjConnect/users/getalllosts"
      
        
    
        
        
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success(let json):
                    
                    
                    
                    if let data = json as? [Any]{
                       // print("All Data: ", data )
                        
                        
                        var missings = [MissingPilgrimage]()
                        for childDic in data{
                            var user = MissingPilgrimage()
                            
                            if let userInfoDic = childDic as? [String: Any] {
                                
                                user.id = userInfoDic["id"] as? String
                                var messages = [MessageUpdate]()
                                if let informationHistory = userInfoDic["informationHistory"]  as? [[String: Any]] {
                                    for info in informationHistory{
                                        var m = MessageUpdate()
                                        m.message = info["information"] as? String
                                        m.name = info["senderName"] as? String
                                        if let base64String = info["senderImage"] as? String{
                                            if let decodedData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
                                                m.image = UIImage(data: decodedData)
                                            }
                                        }
                                        
                                        
                                     
                                        
                                       messages.append(m)
                                    }
                                    
                                    user.informationHistory = messages
//                                var messages  = [PMessage]()
//                                    for b in informationHistory {
//                                        if let message = b as [String: Any]
//
//                                    }
                                    
                                    
                                }
                                    
                                let lostPeriodMill = userInfoDic["lostPeriod"] as? Int
                                
                                //let hours = lostPeriodMill! / 3600000 as? Int
                                
                                var minutes = lostPeriodMill! / 60000
                                
                                var hours = 0
                                if(minutes > 60){
                                    hours = minutes / 60
                                    let minutes = minutes % 60
                                }
                                
                                user.period = hours.description
                                user.period?.append("ساعة")
                                user.period?.append(minutes.description)
                                user.period?.append("دقيقة")
                                    
                                
                                 if let details = userInfoDic["visitor"] as? [String: Any] {
                                    user.id = details["beaconId"] as? String
                                    user.name = details["firstName"] as? String
                                    user.name?.append(" ")
                                    user.name?.append((details["lastName"] as? String)!)
                                 
                                    if  let base64String = details["image"] as? String{
                                        if let decodedData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
                                            user.image = UIImage(data: decodedData)
                                        }
                                    }
                                 
                                    
                                    
                                    
                                }
                              
                              
                          
                                
                                
                            }
                            
                            missings.append(user)
                        }
                        completionHandler(missings)
                    }
                        
                    
  

                    
                case .failure(let err):
                    print(err)
                
                
                
                
    
    
                }
                
                
}
    }}

