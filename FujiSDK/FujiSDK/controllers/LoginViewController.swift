//
//  LoginViewController.swift
//  Fuji_platform_ios
//
//  Created by Fuji on 3/6/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class LoginViewController: BasicViewController {
    
    var callback: (_ isSuccess: Bool, _ message: String) -> Void = {_ in
    }
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var textfieldUsername: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    
    @IBAction func buttonForgotPassword(_ sender: Any) {
        Logger.log(string: "Forgot password")
        
        goToForgotPasswordViewController()
    }
    
    @IBAction func login(_ sender: Any) {
        Logger.log(string: "Clicked login")
        
        if !Utils.isOnline(){
            Alert.show(viewController: self, message: Constant.YOU_ARE_OFFLINE)
            return
        }
        
        login()
    }
    
    @IBAction func signup(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constant.STORY_BOARD_MAIN_NAME, bundle: fujiSdkBundle)
        let signupViewController = storyboard.instantiateViewController(withIdentifier: Constant.STORY_BOARD_SIGNUP_ID) as! SignupViewController
        
        self.navigationController?.pushViewController(signupViewController, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageLogo(imageViewLogo: imageViewLogo)
        
        self.title = Constant.LOGIN_TITLE
        self.textfieldUsername.delegate = self
        self.textfieldPassword.delegate = self
    }

    private func login(){
        let username = textfieldUsername.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = textfieldPassword.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        
        let (isValid, user) = validate()
        
        if !isValid {
            Alert.show(viewController: self, message: Constant.LOGIN_ERROR_MESSAGE)
        } else {
            Indicator.start(context: self.view)

            user?.setPassword(password: (user?.getPassword().sha256())!)
            
            func callback(isSuccess: Bool, message: String) {
                Indicator.stop()
                
                if isSuccess {
                    Toast.show(context: self.view, text: Constant.LOGIN_SUCCESS)
                    
                    goBack()
                    
                } else {
                    Toast.show(context: self.view, text: Constant.LOGIN_FAIL)
                }
                
                self.callback(true, message)
            }
            
            User.login(user: user!, callback: callback)
        }
    }
    
    private func validate() -> (Bool, User?) {
        let username = textfieldUsername.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = textfieldPassword.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (username?.isEmpty)! || (password?.isEmpty)!{
          return (false, nil)
        } else {
            return (true, User.init(username: username!, password: password!))
        }
    }
    
    private func goToForgotPasswordViewController(){
        let storyboard = UIStoryboard(name: Constant.STORY_BOARD_MAIN_NAME, bundle: fujiSdkBundle)
        let forgotPasswordViewController = storyboard.instantiateViewController(withIdentifier: Constant.STORY_BOARD_FORGOT_PASSWORD_ID) as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
}
