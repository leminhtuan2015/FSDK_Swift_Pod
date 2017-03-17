//
//  FujiSDK.swift
//  Fuji_platform_ios
//
//  Created by Fuji on 3/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation
import UIKit

public class FujiSDK {
    public static var PRODUCT_CODE: String = ""
    private var isDebugMode = false
    private var fujiStoryboard: UIStoryboard = UIStoryboard()
    
    public class var Instance: FujiSDK {
        struct Static {
            static let instance: FujiSDK = FujiSDK()
        }
        return Static.instance
    }
    
    init() {
        let bundle = Bundle(path: Bundle(for: LoginViewController.classForCoder()).path(forResource: "FujiSDK", ofType: "bundle")!)
        fujiStoryboard = UIStoryboard(name: Constant.STORY_BOARD_MAIN_NAME, bundle: bundle)
    }
    
    public func initialize (productCode: String) {
        FujiSDK.PRODUCT_CODE = productCode
        User.loadSession()
    }
    
    public func isLoggedIn() -> Bool {
        return User.isLoggedIn()
    }
    
    public func getUserInfo() -> User {
        return User.getCurrentUser()
    }
    
    public func getFCoin() -> Int {
        let fcoin: String = User.getCurrentUser().getFcoin()
        
        return Int(fcoin)!
    }
    
    public func getPaymentPackages(productCode: String, callback: @escaping (_ isSuccess: Bool, _ message: String, _ packages: [Package]) -> Void) {
        Package.getPackages(productCode: productCode, callback: callback)
    }
    
    public func setDebugMode(debugMode: Bool) {
        isDebugMode = debugMode;
    }
    
    public func isInDebugMode() -> Bool {
        return isDebugMode
    }
    
    public func getURL() -> String {
        return isInDebugMode() ? Constant.BACKEND_DEV_URL : Constant.API_URL;
    }
    
    public func login(viewController: UIViewController, callback: @escaping (_ isSuccess: Bool, _ message: String) -> Void) {
        
        if User.isLoggedIn() {
            Toast.show(context: viewController.view, text: Constant.LOGGED_IN)
            
            return
        }
        
        let loginViewController = fujiStoryboard.instantiateViewController(withIdentifier: Constant.STORY_BOARD_LOGIN_ID) as! LoginViewController
        loginViewController.callback = callback
        
        if viewController.navigationController != nil {
            viewController.navigationController?.pushViewController(loginViewController, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: loginViewController)
            viewController.present(navController, animated: true, completion: nil)
        }
        
    }
    
    public func logout(viewController: UIViewController, callback: @escaping (_ isSuccess: Bool, _ message: String) -> Void){
        
        if !User.isLoggedIn() {
            Toast.show(context: viewController.view, text: Constant.NOT_LOGGED_IN)
            
            return
        }
        
        func callbackConfirm(isOk: Bool) {
            if isOk {
                Logger.log(string: "Ok Logout")
                
                func callback (isSuccess: Bool, message: String) {
                    if(isSuccess){
                        Toast.show(context: viewController.view, text: Constant.LOGOUT_SUCCESS)
                        
                        callback( true, Constant.SUCCESS)
                    } else {
                        Toast.show(context: viewController.view, text: Constant.LOGOUT_FAIL)
                        
                        callback(false, Constant.SOMETHING_WENT_WRONG)
                    }
                }
                
                User.logout(callback: callback)
            }
            
        }
        
        Alert.confirm(viewController: viewController, message: Constant.LOGOUT_CONFIRM, callback: callbackConfirm)
        
    }
    
    public func userInfo(viewController: UIViewController){
        if(!User.isLoggedIn()){
            Toast.show(context: viewController.view, text: Constant.NOT_LOGGED_IN)
            return
        }
        
        let userInfoViewController = fujiStoryboard.instantiateViewController(withIdentifier: Constant.STORY_BOARD_USER_INFO_ID) as! UserInfoViewController
        
        if viewController.navigationController != nil {
            viewController.navigationController?.pushViewController(userInfoViewController, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: userInfoViewController)
            viewController.present(navController, animated: true, completion: nil)
        }
    }

    
    public func transferCoin(viewController: UIViewController, packageCode: String, callback: @escaping (_ isSuccess: Bool, _ message: String, _ fcoin: Int) -> Void){
        
        if(!User.isLoggedIn()){
            Toast.show(context: viewController.view, text: Constant.NOT_LOGGED_IN)
            return
        }
        
        let paymentViewController = fujiStoryboard.instantiateViewController(withIdentifier: Constant.STORY_BOARD_PAYMENT_ID) as! PaymentViewController
        paymentViewController.callback = callback
        paymentViewController.setPackageCode(packageCode: packageCode)
        
        if viewController.navigationController != nil {
            viewController.navigationController?.pushViewController(paymentViewController, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: paymentViewController)
            viewController.present(navController, animated: true, completion: nil)
        }
    }
}











