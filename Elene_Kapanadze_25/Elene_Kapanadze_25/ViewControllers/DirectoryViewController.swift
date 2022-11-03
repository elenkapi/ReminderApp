//
//  DirectoryViewController.swift
//  Elene_Kapanadze_25
//
//  Created by Ellen_Kapii on 24.08.22.
//

import UIKit

class DirectoryViewController: UIViewController {
    
    
    private lazy var directoryTableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        return tableView
    }()
    
    
    let manager = FileManagerHelper.shared
    var directories = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUp()
        setUpTableView()
        loadDirectories()
        
        
        
    }
    
    
    
    //MARK: - config private funcs
    
    private func setUp() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem( barButtonSystemItem: .add, target: self,action: #selector(createDirectory))
        
        addDirectoryTableView()
        
    }
    
    private func setUpTableView() {
        directoryTableView.delegate = self
        directoryTableView.dataSource = self
        directoryTableView.register(UINib(nibName: "DirectoryCell", bundle: nil), forCellReuseIdentifier: "DirectoryCell")
        directoryTableView.separatorStyle = .singleLine
        directoryTableView.showsVerticalScrollIndicator = false
        directoryTableView.backgroundColor = .clear
        
    }
    
    //MARK: - Creating and Loading  Directories
    
    
    private func loadDirectories() {
        let result = manager.loadDirectories()
        
        switch result {
            
        case .success(let directories):
            self.directories = directories
        case .failure(let error):
            print(error)
            
        }
    }
    
    @objc func createDirectory() {
        
        let alert = UIAlertController(title: "Add New Directory",
                                      message: "Enter Title",
                                      preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Directory"
        }
        
        alert.addAction(UIAlertAction(title: "Save",
                                      style: .default,
                                      handler: { _ in
            
            guard let directoryField = alert.textFields else { return }
            
            guard let directory = directoryField.first!.text, !directory.isEmpty, !self.directories.contains(directory) else {
                print("This Directory is either Empty or Already Created")
                return
            }
            
            self.manager.createDirectory(name: directory)
            self.directories.append(directory)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
    
    
    //MARK: - Adding constraints to views
    
    private func addDirectoryTableView() {
        
        directoryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let topConstraint = NSLayoutConstraint(item: directoryTableView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 20)
        
        let leftConstraint = NSLayoutConstraint(item: directoryTableView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: directoryTableView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -0)
        
        let bottomConstraint = NSLayoutConstraint(item: directoryTableView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -20)
        
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
    }
    
    
    
    
}

extension DirectoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        directories.count
    
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryCell", for: indexPath) as? DirectoryCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        
        let currentDirectory = directories[indexPath.row]
        cell.directoryName.text = currentDirectory
        
        
        DispatchQueue.main.async {
            self.directoryTableView.reloadData()
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "RemaindersViewController") as? RemaindersViewController
               guard let vc = vc else { return }
               vc.modalPresentationStyle = .fullScreen
                      
               let selectedDirectory = directories[indexPath.row]
               vc.currentDirectory = selectedDirectory
               
               
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
