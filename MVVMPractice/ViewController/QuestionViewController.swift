//
//  ViewController.swift
//  MVVMPractice
//
//  Created by Aki on 2023/10/30.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = QuestionViewModel()
    var questionModel: DataModel?
    
    var test = [1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAllQuestion { [weak self] in
            self?.questionModel = self?.viewModel.questionModel
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                print(self!.questionModel)
            }
        }
        
        
    }

}

extension QuestionViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionModel?.data?.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = questionModel?.data?.questions?[indexPath.row].question
        return cell!
    }
    
    
    
    
    
}
