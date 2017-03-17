//
//  ViewController.swift
//  FujiSDK-Test
//
//  Created by Thuy Dong Xuan on 3/15/17.
//  Copyright © 2017 FujiTech. All rights reserved.
//

import UIKit
import FujiSDK

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    FujiSDK.Instance.initialize(productCode: "RMReMonster")
  }
    
    @IBAction func btnLogin(_ sender: Any) {
        func callback (isSuccess: Bool, message: String) {            
            if(isSuccess){
                print("btnLogin Succeed");
            } else {
                print("btnLogin Failed: " + message);
            }
        }
        
        
        FujiSDK.Instance.login(viewController: self, callback: callback)
    }

    @IBAction func btnLogout(_ sender: Any) {
        
        func callback (isSuccess: Bool, message: String) {
            if(isSuccess){
                print("btnLogout Succeed");
            } else {
                print("btnLogout Failed: " + message);
            }
        }
        
        FujiSDK.Instance.logout(viewController: self, callback: callback)
    }
    
    @IBAction func btnUserInfo(_ sender: Any) {
        FujiSDK.Instance.userInfo(viewController: self)
    }
    
    @IBAction func btnTranferCoin(_ sender: Any) {
        
        func callback (isSuccess: Bool, message: String, coin: Int) {
            if(isSuccess){
                print("btnTransferCoin Succeed");
            } else {
                print("btnTransferCoin Failed: " + message);
            }
        }
        
        
        FujiSDK.Instance.transferCoin(viewController: self, packageCode: "jp.co.alphapolis.games.remon.5", callback: callback)
    }

}

