//
//  AddRemainderViewController.swift
//  Elene_Kapanadze_25
//
//  Created by Ellen_Kapii on 24.08.22.
//

import UIKit

class AddRemainderViewController: UIViewController {

    private lazy var titleField: UITextField = {
        let titleField = UITextField()
        titleField.attributedPlaceholder = NSAttributedString(
            string: " Enter Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        titleField.textColor = .black
        titleField.backgroundColor = .white
        titleField.returnKeyType = .next
        titleField.autocorrectionType = .no
        titleField.layer.cornerRadius = 5
        titleField.layer.masksToBounds = true
        view.addSubview(titleField)
        return titleField
    }()

    private lazy var bodyField: UITextField = {
        let bodyField = UITextField()
        bodyField.attributedPlaceholder = NSAttributedString(
            string: " Enter Body",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        bodyField.textColor = .black
        bodyField.backgroundColor = .white
        bodyField.returnKeyType = .next
        bodyField.autocorrectionType = .no
        bodyField.layer.cornerRadius = 5
        bodyField.layer.masksToBounds = true
        view.addSubview(bodyField)
        return bodyField
    }()


    private lazy var datePicker: UIDatePicker = {
        let datePicker =  UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        view.addSubview(datePicker)
        return datePicker
    }()




    public var completion: ((String, String, Date) -> Void)?

    var remainders = [String:String]()
    let manager = FileManagerHelper.shared
    var currentDirectory = String()

    override func viewDidLoad() {
        super.viewDidLoad()


        setUp()
        loadReminders()


    }




    //MARK: - config private funcs

    private func setUp() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))


        addTitleField()
        addBodyField()
        addDatePicker()

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


    //MARK: - adding taps to buttons

    @objc private func saveTapped() {

        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty {

            let targetDate = datePicker.date
            completion?(titleText, bodyText, targetDate)

            self.manager.createRemainder(name: titleText, currentDirectory: currentDirectory, data: bodyText)
            self.remainders[titleText] = bodyText

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "RemaindersViewController") as? RemaindersViewController
            guard let vc = vc else { return }


            vc.remainders = remainders
            vc.modalPresentationStyle = .fullScreen


            self.navigationController?.pushViewController(vc, animated: true)
          




        }


    }



    //MARK: Adding constraints to views

    private func addTitleField() {

        titleField.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = NSLayoutConstraint(item: titleField,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 50)

        let leftConstraint = NSLayoutConstraint(item: titleField,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 20)

        let rightConstraint = NSLayoutConstraint(item: titleField,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -20)

        let height = NSLayoutConstraint(item: titleField,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: 40)


        NSLayoutConstraint.activate([topConstraint, rightConstraint, leftConstraint, height])
    }

    private func addBodyField() {

        bodyField.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = NSLayoutConstraint(item: bodyField,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: titleField,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 20)

        let leftConstraint = NSLayoutConstraint(item: bodyField,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 20)

        let rightConstraint = NSLayoutConstraint(item: bodyField,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -20)

        let height = NSLayoutConstraint(item: bodyField,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: 40)


        NSLayoutConstraint.activate([topConstraint, rightConstraint, leftConstraint, height])
    }

    private func addDatePicker() {

        datePicker.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = NSLayoutConstraint(item: datePicker,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: bodyField,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 40)

        let leftConstraint = NSLayoutConstraint(item: datePicker,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 0)

        let rightConstraint = NSLayoutConstraint(item: datePicker,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -0)


        let height = NSLayoutConstraint(item: datePicker,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: 200)

        NSLayoutConstraint.activate([topConstraint, rightConstraint, leftConstraint, height])

    }



}
