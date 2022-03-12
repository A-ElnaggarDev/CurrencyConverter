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
}
