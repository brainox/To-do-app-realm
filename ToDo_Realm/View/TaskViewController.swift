//
//  VIewViewController.swift
//  ToDo_Realm
//
//  Created by Decagon on 25/05/2021.
//

import RealmSwift
import UIKit

class TaskViewController: UIViewController {
    
    public var item: TodoListItem?
    public var deletionHandler: (() -> Void)?
    public var updateHandler: (() -> Void)?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBAction func updateButton(_ sender: Any) {
        RealmService.shared.updateTask(itemTextField.text!, category: item!)
        updateHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        itemTextField.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        RealmService.shared.delete(myItem)
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
