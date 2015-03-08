//
//  VoteController.swift
//  Adok
//
//  Created by Remi Robert on 08/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class VoteController: UIViewController, KinderDelegate {

    lazy var kinderController: KinderViewController = {
        let controller = KinderViewController()
        controller.delegate = self
        return controller
    }()
    
    var datas: Array<ChallengeValidation>! = Array()
    
    func acceptCard(card: KinderModelCard?) {
        
    }
    
    func cancelCard(card: KinderModelCard?) {
        
    }
    
    func signalReload() {
        
    }
    
    func reloadCard() -> [KinderModelCard]? {
        return datas
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.pushViewController(kinderController, animated: false)
        //self.presentViewController(kinderController, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Request.launchChallengeValidationRequest(UserInformation.sharedInstance.informations.access_token, blockSuccess: { (operation, responseValidation) -> () in
            println("validations : \(responseValidation)")
            }) { (error) -> () in
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
