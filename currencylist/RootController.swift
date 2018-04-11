//
//  RootController.swift
//  currencylist
//
//  Created by Andrey Oshev on 11/04/2018.
//  Copyright © 2018 Andrey Oshev. All rights reserved.
//

import UIKit

class RootController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        openMain()
    }
    
    fileprivate func openMain() {
        let nc = UINavigationController(rootViewController: MainController())
        self.present(nc, animated: false, completion: nil)
    }
}
