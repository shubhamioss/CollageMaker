//
//  SingupController.swift
//  CollageMaker
//
//  Created by Mac on 26/02/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class SingupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
                let checkUser = UserDefaults.standard.value(forKey: "userLoggedin")
        
                if checkUser != nil{
        
                    if (checkUser as! String == "yes")
                    {
                        let vc = Theme8WalkThroughViewController(nibName: "Theme8WalkThroughViewController", bundle: nil)
                       
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
        
                }else
                {
                    let vc = Theme12SignUpViewController(nibName: "Theme12SignUpViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
