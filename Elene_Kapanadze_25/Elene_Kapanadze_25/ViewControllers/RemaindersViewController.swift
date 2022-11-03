//
//  RemaindersViewController.swift
//  Elene_Kapanadze_25
//
//  Created by Ellen_Kapii on 24.08.22.
//

import UIKit
import UserNotifications

class RemaindersViewController: UIViewController {
    
    private lazy var remaindersTableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        return tableView
    }()
    
    
    var remainders = [String:String]()
    let manager = FileManagerHelper.shared
    var currentDirectory = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setUpTableView()
        loadReminders()
        
        
        
        
    }
    
    
    
    //MARK: - config private funcs
    
    private func setUp() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createRemainder))
        
        addRemaindersTableView()
        
        
    }
    
    private func setUpTableView() {
        remaindersTableView.delegate = self
        remaindersTableView.dataSource = self
        remaindersTableView.register(UINib(nibName: "RemainderCell", bundle: nil), forCellReuseIdentifier: "RemainderCell")
        remaindersTableView.separatorStyle = .singleLine
        remaindersTableView.showsVerticalScrollIndicator = false
        remaindersTableView.backgroundColor = .clear
        
    }
    
    private func loadReminders() {
        let result = manager.loadRemainders(currentDirectory: currentDirectory)
        
        switch result {
        case .success(let remainders):
            self.remainders = remainders
        case .failure(let error):
            print(error)
        }
    }
    
    
    @objc private func createRemainder() {
        
        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
                guard let vc = storyboard.instantiateViewController(withIdentifier: "AddRemainderViewController") as? AddRemainderViewController else { return }
        
                vc.currentDirectory = self.currentDirectory
        
                vc.modalPresentationStyle = .fullScreen
        
                self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
        
        
//        
//        let alert = UIAlertController(title: "Add New Remainder",
//                                      message: "Enter Title and Description",
//                                      preferredStyle: .alert)
//        
//        alert.addTextField { textField in
//            textField.placeholder = "Title"
//        }
//        
//        alert.addTextField { textField in
//            textField.placeholder = "Description"
//        }
//        
//        alert.addAction(UIAlertAction(title: "Save",
//                                      style: .default,
//                                      handler: { [self] _ in
//            
//            guard let remainderFields = alert.textFields else { return }
//            
//            guard let remainderName = remainderFields[0].text, !remainderName.isEmpty else {
//                print("Empty Field")
//                return
//            }
//            guard let remainderBody = remainderFields[1].text, !remainderBody.isEmpty else { print("Empty Field")
//                return
//            }
//            
//            self.manager.createRemainder(name: remainderName, currentDirectory: currentDirectory, data: remainderBody)
//            self.remainders[remainderName] = remainderBody
//        }))
//        
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        
//        present(alert, animated: true)
        
    }
    
    
    
    
    
    
    
    //MARK: - Adding constraints to views
    
    private func addRemaindersTableView() {
        
        remaindersTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let topConstraint = NSLayoutConstraint(item: remaindersTableView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 20)
        
        let leftConstraint = NSLayoutConstraint(item: remaindersTableView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: remaindersTableView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -0)
        
        let bottomConstraint = NSLayoutConstraint(item: remaindersTableView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -20)
        
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
    }
    
    
    
    
}

extension RemaindersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        remainders.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RemainderCell", for: indexPath) as? RemainderCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        
        let currentRemainder = remainders[indexPath.row]
        cell.remainderTitle.text = currentRemainder.key
        cell.remainderBody.text = currentRemainder.value
        
        DispatchQueue.main.async {
            self.remaindersTableView.reloadData()
        }
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
    
    
}

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
