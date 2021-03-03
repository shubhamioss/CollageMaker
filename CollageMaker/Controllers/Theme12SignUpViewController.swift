//
//  Theme12SignUpViewController.swift
//  Social
//
//  Created by ""-ios on 21/01/20.
//  Copyright © 2020 ""-ios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import ANLoader

class Theme12SignUpViewController: UIViewController,UITextFieldDelegate {

    //MARK:-
    //MARK:- Outlets
    
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwpassword: UIView!
    @IBOutlet weak var vwConfirmPassword: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var ConstraintSafeArea: NSLayoutConstraint!
    
    //MARK:-
    //MARK:- UIView Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        SetUpObject()
    }
   
    func SetUpObject() {
        if #available(iOS 11.0, *) {} else {
            ConstraintSafeArea.constant = UIApplication.shared.statusBarFrame.size.height
        }
        
        vwEmail.layer.cornerRadius = 15.0
        vwpassword.layer.cornerRadius = 15.0
        vwConfirmPassword.layer.cornerRadius = 15.0
        btnSignUp.layer.cornerRadius = 15.0
        lblSignUp.attributedText = NSAttributedString(string: "Sign In", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        let gradient = CAGradientLayer()
      //  gradient.colors = [UIColor.init(hexString: THEME12_GRANDIENT_COLOR1).cgColor, UIColor.init(hexString: THEME12_GRANDIENT_COLOR2).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.btnSignUp.layer.addSublayer(gradient)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 120
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        view.endEditing(true)
       return true
    }
    
    //MARK:-
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        
    }
        
    @IBAction func btnSignUp_Clicked(_ sender: Any) {
        
        let username = self.txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = self.txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.txtConfirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) -> Void in
                if (error == nil) {
                                        let db = Firestore.firestore()
                                        db.collection("EditUserBase").document(username).setData([
                                                                                                    "Username": username,"Email" : email,"Coins" : 200]) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                ANLoader.showLoading()
                                                let defaults = UserDefaults.standard
                                                defaults.set(username, forKey: "usernameId")
                                                DispatchQueue.main.async {
                                                    UserDefaults.standard.set(true, forKey: "USERISLOGIN")
                                                   
                                                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let vc : HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                                                    let navigationController = UINavigationController(rootViewController: vc)
                                                    navigationController.modalPresentationStyle = .fullScreen
                                                    self.present(navigationController, animated: true, completion: nil)
                                                    
                                                }
                                            }
                                        }
                }
                else{
                    let alert = UIAlertController(title: "Message", message: "The email address is already in use by another account.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
    }

}
