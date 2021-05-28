//
//  EntryViewController.swift
//  ToDo_Realm
//
//  Created by Decagon on 25/05/2021.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.becomeFirstResponder()
        titleField.delegate = self
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didTapSaveButton() {
        if let text = titleField.text, !text.isEmpty {
            let date = datePicker.date
            
            let newItem = TodoListItem()
            newItem.date = date
            newItem.item = text
            RealmService.shared.create(newItem)
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        } else {
            print("Add something")
        }
    }

}
