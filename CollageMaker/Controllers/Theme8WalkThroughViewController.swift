//
//  Theme8WalkThroughViewController.swift
//  Prokit
//
//  Created by ""-ios on 04/12/19.
//  Copyright © 2019 ""-ios. All rights reserved.
//

import UIKit
import iCarousel
import ANLoader

class Theme8WalkThroughViewController: UIViewController,iCarouselDelegate,iCarouselDataSource {
    
    //MARK:-
    //MARK:- Outlets
    
    @IBOutlet weak var ConstraintSafeArea: NSLayoutConstraint!
    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var vwCarousel: iCarousel!
    @IBOutlet weak var lblTitle: UILabel!
        
    //MARK:-
    //MARK:- Variables.
    
    var arrWalkThroughImage = ["grids","editors","photos"]
    var arrWalkThroughTitle = ["Grids Editor","Photo Editor","Photos"]
    
    //MARK:-
    //MARK:- UIView Life Cycles.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ANLoader.hide()
        UserDefaults.standard.set("yes", forKey: "userLoggedin")

        // Do any additional setup after loading the view.
        SetUpObject()
    }
    
    //MARK:-
    //MARK:- SetUpObject Methods
    
    func SetUpObject() {
        if #available(iOS 11.0, *) {
                            
        } else {
            // Fallback on earlier versions
            ConstraintSafeArea.constant = UIApplication.shared.statusBarFrame.size.height
        }
        self.navigationController?.isNavigationBarHidden = true
        
        vwCarousel.type = .rotary
        vwCarousel.delegate = self
        vwCarousel.dataSource = self
        vwCarousel.isPagingEnabled = true
        self.btnGetStarted.layer.cornerRadius = self.btnGetStarted.frame.height / 2
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return arrWalkThroughImage.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: (self.vwCarousel.frame.width / 2), height: self.vwCarousel.frame.height))
        let frame = CGRect(x: 0, y: 0, width: tempView.frame.width, height: tempView.frame.height)
        let imageView = UIImageView()
        imageView.frame = frame
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: arrWalkThroughImage[index])
        tempView.addSubview(imageView)
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.6
        }
        return value
    }
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let index = carousel.currentItemIndex
        self.lblTitle.text = arrWalkThroughTitle[index]
    }
    
    //MARK:-
    //MARK:- UIButton Clicked Events
    
    @IBAction func btnGetStart_Clicked(_ sender: UIButton) {
       
        if (self.lblTitle.text! == "Grids Editor"){
      
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoadShapesVC") as! LoadShapesVC
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
            
        }else if(self.lblTitle.text! == "Photo Editor"){
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let obj = storyBoard.instantiateViewController(withIdentifier: "PresentPhotoVC") as! PresentPhotoVC
            obj.objSelectiontype = 2
            let navController = UINavigationController(rootViewController: obj)
            navController.navigationBar.isHidden = true
            navController.modalPresentationStyle = .overCurrentContext
            self.present(navController, animated:true, completion: nil)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyAlbumVC") as! MyAlbumVC
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLogin_Clicked(_ sender: Any) {
    }
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)

    }
}
