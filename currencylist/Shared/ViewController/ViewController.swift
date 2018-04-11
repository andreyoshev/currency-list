//
//  ViewController.swift
//  currencylist
//
//  Created by Andrey Oshev on 11/04/2018.
//  Copyright © 2018 Andrey Oshev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setupView() {
        self.view.backgroundColor = UIColor.white
    }
    
    public func relayout() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        view.setNeedsUpdateConstraints()
    }
}
