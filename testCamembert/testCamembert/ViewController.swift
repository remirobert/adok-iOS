//
//  ViewController.swift
//  testCamembert
//
//  Created by Remi Robert on 15/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class Book :CamembertModel {
    var title :TEXT = ""
    var numberPage :INTEGER = 0
    var currentPage :INTEGER = 0
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    Camembert.initDataBase("dataBase.sql")

    var newBook = Book()
    newBook.title = "La Fontaine : Fables"
    newBook.numberPage = 544
    newBook.currentPage = 43
    newBook.push()
    
}

