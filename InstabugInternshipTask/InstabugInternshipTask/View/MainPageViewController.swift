//
//  MainPageViewController.swift
//  InstabugInternshipTask
//
//  Created by Mohamed Khalid on 25/05/2021.
//

import UIKit


class MainPageViewController: ViewController {
    let logger = Logger()
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        messageTextField.delegate = self
        levelTextField.delegate = self
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if (levelTextField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Please insert level number", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let message = messageTextField.text!
        let level = Int64(levelTextField.text!)!
        logger.addLogElement(message: message, level: level)
        messageTextField.text = ""
        levelTextField.text = ""
    }
    @IBAction func printAllButtonPressed(_ sender: Any) {
        logger.printLog()
    }
}

extension MainPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
