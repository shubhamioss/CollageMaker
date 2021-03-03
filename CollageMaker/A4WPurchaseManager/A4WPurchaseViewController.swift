//
//  A4WPurchaseViewController.swift
//  InstaPostMaker
//
//  Created by Apps4World on 11/3/19.
//  Copyright © 2019 Apps4World. All rights reserved.
//

import UIKit

// This class represents the in-app purchase controller
class A4WPurchaseViewController: UIViewController {
    
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?

    @IBOutlet weak private var purchaseTitle: UILabel!
    @IBOutlet weak private var purchaseDescription: UILabel!
    @IBOutlet weak private var buyProductButton: UIButton!
    @IBOutlet var buyProductButtonNew: UIButton!
    @IBOutlet weak private var legalDisclaimer: UILabel!
    @IBOutlet weak private var closeButton: UIButton!
    var didPurchaseProduct: ((_ success: Bool) -> Void)? = nil
    
    /// Initial logic when this screen loads
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRoundedCornerButtons()
        setupLabelsContent()
        
        let defaults = UserDefaults.standard

        let userAge = defaults.string(forKey: "serviceCheck")

        if userAge == "open"
        {setupLabelsContentOne()}else
        {setupLabelsContent()}
        
    }
        
    /// Setup rounded corners for close and buy buttons
    private func setupRoundedCornerButtons() {
        closeButton.layer.cornerRadius = 12.5
        buyProductButton.layer.cornerRadius = 10
        buyProductButtonNew.layer.cornerRadius = 10

    }
    
    /// Setup content for all labels
    private func setupLabelsContent() {
        purchaseTitle.text = "PRO Version"
        purchaseDescription.text = "- Unlock all templates\n- Unlock all Hashtags\n- Unlock All Trending Grids\n- Remove all ads\n\n\n3-Days Free Trial after that"
        legalDisclaimer.text = "subscription automatically renews for the same price and duration period as the original one month package unless auto-renew is turned off at least 24-hours before the end of the current period .You may cancel a subscription during its free 3days period via the subscription setting through your iTunes account. This must be done 24 hours before the end of the subscription period to avoid being charged. Please visit http://support.apple.com/kb/ht4098 for more information"
        
        let a = UserDefaults.standard.string(forKey: "mainCurrency")
        let b = UserDefaults.standard.string(forKey: "mainPrice")
        let first = "then " + a! + " " + b! + "/Month, Cancel Anytime."
        
        let c = UserDefaults.standard.string(forKey: "mainCurrencyone")
        let d = UserDefaults.standard.string(forKey: "mainPriceone")
        let second = "then " + c! + " " + d! + "/Week, Cancel Anytime."
        
        buyProductButton .setTitle(first, for: .normal)
        buyProductButtonNew .setTitle(second, for: .normal)
        
    }
    
    
    private func setupLabelsContentOne() {
        purchaseTitle.text = "PRO Version"
        purchaseDescription.text = "- Unlock all templates\n- Unlock all Hashtags\n- Unlock All Trending Grids\n- Explore Yourself\n- Unlimited Profile Visit\n- Remove all ads\n\n\n3-Days Free Trial after that"
        legalDisclaimer.text = "subscription automatically renews for the same price and duration period as the original one month package unless auto-renew is turned off at least 24-hours before the end of the current period .You may cancel a subscription during its free 3days period via the subscription setting through your iTunes account. This must be done 24 hours before the end of the subscription period to avoid being charged. Please visit http://support.apple.com/kb/ht4098 for more information"
        
        let a = UserDefaults.standard.string(forKey: "mainCurrency")
        let b = UserDefaults.standard.string(forKey: "mainPrice")
        let first = "then " + a! + " " + b! + "/Month, Cancel Anytime."
        
        buyProductButton .setTitle(first, for: .normal)
        
    }
    
    /// Buy PRO Version
    @IBAction func buyPROVersion(_ sender: UIButton) {
        A4WPurchaseManager.buyProVersion { (success) in
            self.dismiss(animated: true) {
                self.didPurchaseProduct?(success)
                
               // UserDefaults.standard.set("true", forKey: "subscriptionKey")
            }
        }
    }
    @IBAction func buyProductBtnNewAction(_ sender: UIButton) {
        A4WPurchaseManager.buyProVersionOne { (success) in
            self.dismiss(animated: true) {
                self.didPurchaseProduct?(success)
                
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
        UIApplication.shared.open(URL(string: "http://igtags.nl/TermsBesties")!, options: [:], completionHandler: nil)
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

