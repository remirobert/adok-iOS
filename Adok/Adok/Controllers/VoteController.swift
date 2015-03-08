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
    
    var datas: Array<KinderModelCard>! = Array()
    
    func acceptCard(card: KinderModelCard?) {
        
    }
    
    func cancelCard(card: KinderModelCard?) {
        
    }
    
    func signalReload() {
        println("signal reload get")
        Request.launchChallengeValidationRequest(UserInformation.sharedInstance.informations.access_token, blockSuccess: { (operation, responseValidation) -> () in
            println("validations : \(responseValidation)")
            self.datas.removeAll(keepCapacity: false)
            for currentModel in responseValidation! {
                self.datas.append(currentModel)
            }
            self.kinderController.reloadData()
            }) { (error) -> () in
                AlertView.displayAlertView(self.view, title: "Erreur de conncetion réseau", message: "Impossible de récurer la liste de validation.")
        }
    }
    
    func reloadCard() -> [KinderModelCard]? {
        println("send data : \(self.datas)")
        return datas
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.pushViewController(kinderController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Request.launchChallengeValidationRequest(UserInformation.sharedInstance.informations.access_token, blockSuccess: { (operation, responseValidation) -> () in
            println("validations : \(responseValidation)")
            self.datas.removeAll(keepCapacity: false)
            for currentModel in responseValidation! {
                self.datas.append(currentModel)
            }
            self.kinderController.reloadData()
            }) { (error) -> () in
                AlertView.displayAlertView(self.view, title: "Erreur de conncetion réseau", message: "Impossible de récurer la liste de validation.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
