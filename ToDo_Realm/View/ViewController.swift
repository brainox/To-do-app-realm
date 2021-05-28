//
//  ViewController.swift
//  ToDo_Realm
//
//  Created by Decagon on 24/05/2021.
//

import UIKit
import RealmSwift

/*
 - To show list of current to do list item
 - To enter new to do list items
 - To show previously entered to do list items
 - To implement MVVM Design Pattern
 */

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    private var realm = try! Realm()
    private var data = [TodoListItem()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(TodoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        
    }
    
    // MARK: Table Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    // MARK: deleting function with sliding animation
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        if editingStyle == .delete {
            RealmService.shared.delete(item)
            self.refresh()
        }
    }
    
    // MARK: deleting an item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        // open the screen where we can see the item info and delete
        let item = data[indexPath.row]
        
        guard let newViewController = storyboard?.instantiateViewController(identifier: "taskView") as? TaskViewController else {
            return
        }
        
        newViewController.item = item
        newViewController.deletionHandler = { [weak self] in
            self?.refresh()
        }
        newViewController.updateHandler = { [weak self] in
            self?.refresh()
        }
        newViewController.navigationItem.largeTitleDisplayMode = .never
        newViewController.title = item.item
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    // MARK: Bar Button Item
    @IBAction func didTapAddButton() {
        guard let entryVCInstance = storyboard?.instantiateViewController(withIdentifier: "enter") as? EntryViewController else {
            return
        }
        entryVCInstance.completionHandler = { [weak self] in
            self?.refresh()
            
        }
        entryVCInstance.title = "New Item"
        entryVCInstance.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(entryVCInstance, animated: true)
    }
    
    func refresh() {
        data = realm.objects(TodoListItem.self).map({ $0 })
        table.reloadData()
    }
}
