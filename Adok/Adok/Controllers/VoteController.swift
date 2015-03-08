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

    var isRequesting = false
    var datas: Array<KinderModelCard>! = Array()
    
    func acceptCard(card: KinderModelCard?) {
        if let validationChallenge = card as? ChallengeValidation {
            isRequesting = true
            Request.LaunchUpvoteRequest(UserInformation.sharedInstance.informations.access_token,
                validationId: validationChallenge.id, blockSuccess: { (operation) -> () in
                    self.isRequesting = false
                }) { (error) -> () in
                    self.isRequesting = false
            }
        }
    }
    
    func cancelCard(card: KinderModelCard?) {
        if let validationChallenge = card as? ChallengeValidation {
            self.isRequesting = false
            Request.LaunchDownvoteRequest(UserInformation.sharedInstance.informations.access_token,
                validationId: validationChallenge.id, blockSuccess: { (operation) -> () in
                    self.isRequesting = false
                }) { (error) -> () in
                    self.isRequesting = false
            }
        }
    }
    
    func signalReload() {
        if isRequesting == true {
            return
        }
        Request.launchChallengeValidationRequest(UserInformation.sharedInstance.informations.access_token, blockSuccess: { (operation, responseValidation) -> () in
            if self.datas != nil {
                self.datas.removeAll(keepCapacity: false)
            }
            if responseValidation == nil {
                self.datas = nil
                return
            }
            for currentModel in responseValidation! {
                if self.datas == nil {
                    self.datas = Array()
                }
                self.datas.append(currentModel)
            }
            self.kinderController.reloadData()
            }) { (error) -> () in
                AlertView.displayAlertView(self.view, title: "Erreur de conncetion réseau", message: "Impossible de récurer la liste de validation.")
        }
    }
    
    func reloadCard() -> [KinderModelCard]? {
        return datas
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.pushViewController(kinderController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signalReload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
