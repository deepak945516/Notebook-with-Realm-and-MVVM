//
//  TaskDetailViewController.swift
//  RealmTest
//
//  Created by Deepak Kumar on 30/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit

protocol SaveButtonDelegate: class {
    func saveButtonClicked(taskData: Task, isEdit: Bool, index: Int)
}

final class TaskDetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var saveEditButton: UIButton!
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var taskDetailViewModel: TaskDetailViewModel!
    weak var delegate: SaveButtonDelegate?
    var isEdit: Bool = false
    var selectedIndex = 0
    var isEditTemp: Bool = false

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Private Methods
    private func initialSetup() {
        isEditTemp = isEdit
        noteTitleTextField.text = taskDetailViewModel.model.taskName
        noteTextView.text = taskDetailViewModel.model.taskDetail
        if isEdit {
            saveEditButton.setTitle("Edit", for: .normal)
            noteTitleTextField.isEnabled = false
            noteTextView.isEditable = false
        } else {
            noteTitleTextField.becomeFirstResponder()
            saveEditButton.setTitle("Save", for: UIControlState.normal)
        }
    }
    // MARK: - IBAction Methods
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveEditButtonTapped(_ sender: UIButton) {
        if isEditTemp {
            saveEditButton.setTitle("Save", for: UIControlState.normal)
            noteTitleTextField.isEnabled = true
            noteTextView.isEditable = true
            isEditTemp = false
        } else if (noteTitleTextField.text?.count)! > 0 {
            let newTask = taskDetailViewModel.createNewModel
            newTask.taskName = noteTitleTextField.text!
            newTask.taskDetail = noteTextView.text
            if isEdit == false {
                newTask.ID = taskDetailViewModel.generateUniqueKey(taskName: taskDetailViewModel.model.taskName)
            } else {
                newTask.ID = taskDetailViewModel.model.ID
            }
            delegate?.saveButtonClicked(taskData: newTask, isEdit: isEdit, index: selectedIndex)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - TextField and TextView Delegate
extension TaskDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteTextView.becomeFirstResponder()
        return true
    }
}
