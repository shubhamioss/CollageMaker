//
//  A4WPurchaseViewController.swift
//  InstaPostMaker
//
//  Created by Apps4World on 11/3/19.
//  Copyright © 2019 Apps4World. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

// This class represents the in-app purchase controller
class A4WPurchaseViewController: UIViewController {
    
    var coinsCount : Int = 0
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?

    @IBOutlet weak private var purchaseTitle: UILabel!
    @IBOutlet weak private var purchaseDescription: UILabel!
    @IBOutlet weak private var buyProductButton: UIButton!
    @IBOutlet var buyProductButtonNew: UIButton!
    @IBOutlet weak private var legalDisclaimer: UILabel!
    @IBOutlet weak private var closeButton: UIButton!
    var didPurchaseProduct: ((_ success: Bool) -> Void)? = nil
    
    @IBOutlet var buyCoinsBtnOne: UIButton!
    @IBOutlet var buyCoinsBtnTwo: UIButton!
    @IBOutlet var buyCoinsBtnThree: UIButton!
    @IBOutlet var buyCoinsBtnFour: UIButton!
    @IBOutlet var buyCointBtnFive: UIButton!
    /// Initial logic when this screen loads
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRoundedCornerButtons()
        
        let defaults = UserDefaults.standard

        let userAge = defaults.string(forKey: "serviceCheck")

        if userAge == "open"
        {setupLabelsContentOne()}else
        {setupLabelsContent()}
        
        fetchCurrentUserDocument()
        
    }
        
    /// Setup rounded corners for close and buy buttons
    private func setupRoundedCornerButtons() {
        closeButton.layer.cornerRadius = 12.5
        buyCoinsBtnOne.layer.cornerRadius = 10
        buyCoinsBtnTwo.layer.cornerRadius = 10
        buyCoinsBtnThree.layer.cornerRadius = 10
        buyCoinsBtnFour.layer.cornerRadius = 10
        buyCointBtnFive.layer.cornerRadius = 10


    }
    
    /// Setup content for all labels
    private func setupLabelsContent() {
        
        let a = UserDefaults.standard.string(forKey: "firstCoinsCurrency")
                  let b = UserDefaults.standard.string(forKey: "firstCoinsPrice")
                  let first = "  " + a! + "" + b! + " - 100000Coins "
                  
                  let c = UserDefaults.standard.string(forKey: "secondCoinsCurrency")
                  let d = UserDefaults.standard.string(forKey: "secondCoinsPrice")
                  let second = "  " + c! + "" + d! + " - 10000Coins"
                  
                  
                  let e = UserDefaults.standard.string(forKey: "thirdCoinsCurrency")
                  let f = UserDefaults.standard.string(forKey: "thirdCoinsPrice")
                  let third = "  " + e! + "" + f! + " - 1000Coins"
                  
                  let i = UserDefaults.standard.string(forKey: "fourCoinsCurrency")
                  let j = UserDefaults.standard.string(forKey: "fourCoinsPrice")
                  let fourth = "  " + i! + "" + j! + " - 50000Coins"
                  
                  let k = UserDefaults.standard.string(forKey: "fiveCoinsCurrency")
                  let l = UserDefaults.standard.string(forKey: "fiveCoinsPrice")
                  let five = "  " + k! + "" + l! + " - 200Coins"
        
        buyCoinsBtnOne .setTitle(first, for: .normal)
        buyCoinsBtnTwo .setTitle(second, for: .normal)
        buyCoinsBtnThree .setTitle(third, for: .normal)
        buyCoinsBtnFour .setTitle(fourth, for: .normal)
        buyCointBtnFive .setTitle(five, for: .normal)
        
    }
    
    
    private func setupLabelsContentOne() {
        
         let a = UserDefaults.standard.string(forKey: "firstCoinsCurrency")
            let b = UserDefaults.standard.string(forKey: "firstCoinsPrice")
            let first = "  " + a! + "" + b! + " - 100000Coins "
            
            let c = UserDefaults.standard.string(forKey: "secondCoinsCurrency")
            let d = UserDefaults.standard.string(forKey: "secondCoinsPrice")
            let second = "  " + c! + "" + d! + " - 10000Coins"
            
            
            let e = UserDefaults.standard.string(forKey: "thirdCoinsCurrency")
            let f = UserDefaults.standard.string(forKey: "thirdCoinsPrice")
            let third = "  " + e! + "" + f! + " - 1000Coins"
            
            let i = UserDefaults.standard.string(forKey: "fourCoinsCurrency")
            let j = UserDefaults.standard.string(forKey: "fourCoinsPrice")
            let fourth = "  " + i! + "" + j! + " - 50000Coins"
            
            let k = UserDefaults.standard.string(forKey: "fiveCoinsCurrency")
            let l = UserDefaults.standard.string(forKey: "fiveCoinsPrice")
            let five = "  " + k! + "" + l! + " - 200Coins"
              
              buyCoinsBtnOne .setTitle(first, for: .normal)
              buyCoinsBtnTwo .setTitle(second, for: .normal)
              buyCoinsBtnThree .setTitle(third, for: .normal)
              buyCoinsBtnFour .setTitle(fourth, for: .normal)
              buyCointBtnFive .setTitle(five, for: .normal)
        
    }
    
    func fetchCurrentUserDocument(){
        let db = Firestore.firestore()
        
        let defaults = UserDefaults.standard
        let currentUsername = defaults.value(forKey: "usernameId")
        let docRef = db.collection("EditUserBase").document("\(currentUsername ?? "shubham456")")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.coinsCount = document["Coins"] as! Int
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateCoins(coins: Int){
         let db = Firestore.firestore()
          
          let tempCoint = self.coinsCount + coins

          let defaults = UserDefaults.standard
          let currentUsername = defaults.value(forKey: "usernameId")
          db.collection("EditUserBase").document("\(currentUsername ?? "shubham456")").updateData(["Coins":tempCoint])
          
      }
    
    /// Buy PRO Version
    @IBAction func buyPROVersion(_ sender: UIButton) {
        A4WPurchaseManager.buyProVersion { (success) in
            self.dismiss(animated: true) {
                self.didPurchaseProduct?(success)
                
                self.updateCoins(coins: 100000)
                // UserDefaults.standard.set("true", forKey: "subscriptionKey")
            }
        }
    }
    @IBAction func buyProductBtnNewAction(_ sender: UIButton) {
        A4WPurchaseManager.buyProVersionOne { (success) in
            self.dismiss(animated: true) {
                self.didPurchaseProduct?(success)
                
                self.updateCoins(coins: 10000)
            }
        }
    }
    
    @IBAction func buyProductThreeBtnAction(_ sender: UIButton) {
        A4WPurchaseManager.buyProVersionTwo { (success) in
                   self.dismiss(animated: true) {
                       self.didPurchaseProduct?(success)
                       self.updateCoins(coins: 1000)
                      // UserDefaults.standard.set("true", forKey: "subscriptionKey")
                   }
               }
    }
    
    @IBAction func buyProductFourBtnAction(_ sender: UIButton) {
        A4WPurchaseManager.buyProVersionThree { (success) in
                          self.dismiss(animated: true) {
                              self.didPurchaseProduct?(success)
                              self.updateCoins(coins: 50000)
                             // UserDefaults.standard.set("true", forKey: "subscriptionKey")
                          }
                      }
    }
    
    @IBAction func buyProductFiveBtnAction(_ sender: UIButton) {
        
        A4WPurchaseManager.buyProVersionfour { (success) in
                          self.dismiss(animated: true) {
                              self.didPurchaseProduct?(success)
                              self.updateCoins(coins: 200)
                             // UserDefaults.standard.set("true", forKey: "subscriptionKey")
                          }
                      }
    }
    
    /// Restore purchases
    @IBAction func restorePurchase(_ sender: UIButton) {
        A4WPurchaseManager.restorePurchases { (success) in
            self.dismiss(animated: true) {
                self.didPurchaseProduct?(success)
            }
        }
    }
    
    /// Open Terms of Use URL
    @IBAction func seeTermsOfUse(_ sender: UIButton) {

    }
    
    /// Open Privacy Policy URL
    @IBAction func seePrivacyPolicy(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://igtags.nl/PrivacyBesties")!, options: [:], completionHandler: nil)
    }
    
    /// Dismiss purchase screen
    @IBAction func closePurchaseScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

