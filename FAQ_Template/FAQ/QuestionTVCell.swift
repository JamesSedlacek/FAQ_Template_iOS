//
//  QuestionTVCell.swift
//  QuestionTVCell
//
//  Created by James Sedlacek on 9/4/21.
//

import UIKit
import Darwin

class QuestionTVCell: UITableViewCell {
    
    // MARK: - Variables
    
    var isAnswerVisible = false
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    
    // MARK: - Functions

    func animateChevron() {
        isAnswerVisible.toggle()
        let toValue = isAnswerVisible ? (CGFloat.pi / 2) : 0.0
        let fromValue = isAnswerVisible ? 0.0 : (CGFloat.pi / 2)
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.25
        animation.isCumulative = true
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        chevronImageView.layer.add(animation, forKey: "rotationAnimation")
    }
}
