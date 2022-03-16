//
//  ControllerExtension.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //this function to show currncies as a drop list
    func selectItem(title: String, source: [String], completion: @escaping (String) -> ()) {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: .actionSheet)
        source.forEach({ string in
            let action = UIAlertAction.init(title: string, style: .default) { _ in
                completion(string)
            }
            alertController.addAction(action)
        })
        let action = UIAlertAction.init(title: "Cancel", style: .cancel) { _ in
            
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func show(errorAlert error: NSError) {
        show(error.localizedDescription)
    }
    
    func show(messageAlert title: String, message: String? = "", actionTitle: String? = nil, action: ((UIAlertAction) -> Void)? = nil) {
        show(title, message: message, actionTitle: actionTitle, action: action)
    }
    
    fileprivate func show(_ title: String,  message: String? = "", actionTitle: String? = nil , action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let _actionTitle = actionTitle {
            alert.addAction(UIAlertAction(title: _actionTitle , style: .default, handler: action))
        }
        
        alert.addAction(UIAlertAction(title:"close" , style: .cancel,  handler: action))
        
        present(alert, animated: true, completion: nil)
    }
}
