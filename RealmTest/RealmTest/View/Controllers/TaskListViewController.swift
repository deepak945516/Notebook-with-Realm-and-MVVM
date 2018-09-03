//
//  ViewController.swift
//  RealmTest
//
//  Created by Deepak Kumar on 29/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var taskListtableView: UITableView!
    @IBOutlet private weak var viewModel: ViewModel!

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods
    private func initialSetup() {
        self.taskListtableView.register(UINib.init(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        self.viewModel.loadDataFromDb()
        self.taskListtableView.reloadData()
    }

    // MARK: - IBAction Methods
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let taskDetailViewController = storyboard.instantiateViewController(withIdentifier: "TaskDetailViewController") as? TaskDetailViewController {
            taskDetailViewController.isEdit = false
            taskDetailViewController.delegate = self
            self.navigationController?.pushViewController(taskDetailViewController, animated: true)
        }
    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table View DataSource and Delegate
extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsAtSection(section: section)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else { return UITableViewCell() }
        let cellData = viewModel.getCellData(atIndex: indexPath.row) as Task
        cell.noteTitleLabel.text = cellData.taskName
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction.init(style: .destructive, title: "Delete") { (deleteAction, indexPath) in
            self.viewModel.deleteData(atIndex: self.viewModel.model.taskList.count - 1 - indexPath.row)
            self.taskListtableView.reloadData()
        }
        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let detailTaskViewController = storyboard.instantiateViewController(withIdentifier: "TaskDetailViewController") as? TaskDetailViewController {
            detailTaskViewController.taskDetailViewModel.model = viewModel.model.taskList[self.viewModel.model.taskList.count - 1 - indexPath.row]
            detailTaskViewController.isEdit = true
            detailTaskViewController.delegate = self
            detailTaskViewController.selectedIndex = self.viewModel.model.taskList.count - 1 - indexPath.row
            self.navigationController?.pushViewController(detailTaskViewController, animated: true)
        }
    }
}

// MARK: - SaveButtonDelegate
extension TaskListViewController: SaveButtonDelegate {
    func saveButtonClicked(taskData: Task, isEdit: Bool, index: Int) {
        if isEdit {
            self.viewModel.model.taskList[index] = taskData
            self.viewModel.database.updateTask(task: taskData)
        } else {
            viewModel.model.taskList.append(taskData)
            viewModel.database.addDataToDb(object: taskData)
        }
        self.taskListtableView.reloadData()
    }


}

