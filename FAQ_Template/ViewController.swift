//
//  ViewController.swift
//  FAQ_Template
//
//  Created by James Sedlacek on 9/4/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faqButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    private func setupButton() {
        faqButton.layer.cornerRadius = faqButton.frame.height / 2
        faqButton.setTitle("Go To FAQ Screen", for: .normal)
    }
}

