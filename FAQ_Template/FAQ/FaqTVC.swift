//
//  FaqTVC.swift
//  Charity
//
//  Created by James Sedlacek on 7/10/21.
//

import UIKit

struct FAQ {
    let question: String
    let answer: String
    var isOpen: Bool = false
}

class FaqTVC: UITableViewController {
    
    // MARK: - Variables
    
    let questionIdentifier = "QuestionTVCell"
    let answerIdentifier = "AnswerTVCell"
    let questionRow = 0
    let answerRow = 1
    var faqs: [FAQ] = [FAQ(question: "Placeholder Question 1",
                           answer: "Placeholder Answer 1"),
                       FAQ(question: "Placeholder Question 2",
                           answer: "Placeholder Answer 2"),
                       FAQ(question: "Placeholder Question 3",
                           answer: "Placeholder Answer 3, example of a really long answer."),
                       FAQ(question: "Placeholder Question 4, example of a really long question.",
                           answer: "Placeholder Answer 4"),
                       FAQ(question: "Placeholder Question 5",
                           answer: "Placeholder Answer 5")]
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        if let navController = navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: questionIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: questionIdentifier)
        
        tableView.register(UINib(nibName: answerIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: answerIdentifier)
    }
    
    // MARK: - Number of Rows & Sections
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return faqs.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqs[section].isOpen ? 2 : 1
    }
    
    // MARK: - Cell for Row
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MARK: - Question
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: questionIdentifier) as? QuestionTVCell else {
                return UITableViewCell()
            }
            
            cell.questionLabel.text = faqs[indexPath.section].question
            
            return cell
        }
        
        // MARK: - Answer
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: answerIdentifier) as? AnswerTVCell else {
                return UITableViewCell()
            }
            
            cell.answerLabel.text = faqs[indexPath.section].answer
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Did Select
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == questionRow {
            guard let cell = tableView.cellForRow(at: indexPath) as? QuestionTVCell else { return }
            let answerIndexPath = IndexPath(row: answerRow,
                                            section: indexPath.section)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.faqs[indexPath.section].isOpen.toggle()
                if self.faqs[indexPath.section].isOpen {
                    tableView.insertRows(at: [answerIndexPath], with: .fade)
                } else {
                    tableView.deleteRows(at: [answerIndexPath], with: .fade)
                }
                cell.animateChevron()
                
                self.closeAllAnswers(exceptFor: indexPath.section)
            }
        }
    }
    
    // MARK: - Close All Answers
    
    ///  Closes all answers except for the section that was Selected
    /// - Parameter exceptionSectionindex: The section that was Selected
    private func closeAllAnswers(exceptFor exceptionSectionindex: Int) {
        // Loop through all of the FAQ
        for sectionIndex in  0..<self.faqs.count {
            
            // if the section is not the section that was Selected
            if sectionIndex != exceptionSectionindex {
                
                // if the FAQ is Open, close it
                if self.faqs[sectionIndex].isOpen {
                    let qIndexPath = IndexPath(row: questionRow, section: sectionIndex)
                    let aIndexPath = IndexPath(row: answerRow, section: sectionIndex)
                    guard let qCell = tableView.cellForRow(at: qIndexPath) as? QuestionTVCell else { return }
                    self.faqs[sectionIndex].isOpen.toggle()
                    tableView.deleteRows(at: [aIndexPath], with: .fade)
                    qCell.animateChevron()
                    return // We return here because there should only be 1 Answer open at a time
                }
            }
        }
    }
    
    // MARK: - Height for Header & Footer

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
