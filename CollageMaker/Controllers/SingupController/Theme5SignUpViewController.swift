//
//  Theme5SignUpViewController.swift
//  Prokit
//
//  Created by ""-ios on 12/12/19.
//  Copyright © 2019 "". All rights reserved.
//

import UIKit
import CountryPicker

class Theme5SignUpViewController: UIViewController, CountryPickerDelegate, UITextFieldDelegate {
    
    
    //MARK:-
    //MARK:- Outlets.
    
    @IBOutlet weak var txtPhoneNo: UITextField!
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    @IBOutlet weak var vwDetail: UIView!
      
    @IBOutlet weak var lblPhoneCode: UILabel!
      
    @IBOutlet weak var phoneNoPicker: CountryPicker!

    @IBOutlet weak var imgFlag: UIImageView!
      
    @IBOutlet weak var ConstraintSafeArea: NSLayoutConstraint!
    
    //MARK:-
    //MARK:- UIview Life Cycles.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetUpObject()
    }
    
    //MARK:-
    //MARK:- SetUpObject Methods.
       
    func SetUpObject() {
        if #available(iOS 11.0, *) {
                           
        } else {
            // Fallback on earlier versions
            ConstraintSafeArea.constant = UIApplication.shared.statusBarFrame.size.height
        }

        self.btnContinue.layer.cornerRadius = 10.0
        self.vwDetail.layer.cornerRadius = 10.0
           
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
           
        phoneNoPicker.setCountry(code!)
        phoneNoPicker.backgroundColor = .white
    }
    
    // a picker item was selected

    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
         lblPhoneCode.text = phoneCode
         imgFlag.image = flag
    }
     
     //MARK:-
     //MARK:- UITextField Delegate Methods.
     
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneNoPicker.isHidden = true
        btnDone.isHidden = true
    }
    
    
    //MARK:-
    //MARK:- UIButton Clicked Events.
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPhoneCode_Clicked(_ sender: Any) {
        view.endEditing(true)
        phoneNoPicker.isHidden = false
        btnDone.isHidden = false
           //init Picker
        let theme = CountryViewTheme(countryCodeTextColor: .black, countryNameTextColor: .black, rowBackgroundColor: .white, showFlagsBorder: false)
        phoneNoPicker.theme = theme
        phoneNoPicker.countryPickerDelegate = self
        phoneNoPicker.showPhoneNumbers = true
    }
    
    @IBAction func btnDone_Clicked(_ sender: Any) {
        phoneNoPicker.isHidden = true
        btnDone.isHidden = true
    }
    
    @IBAction func btnContinue_Clicked(_ sender: Any) {
        THelper.btnAnimationLong(btn: self.btnContinue)
        let vc = Theme5VerificationViewController(nibName: "Theme5VerificationViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
