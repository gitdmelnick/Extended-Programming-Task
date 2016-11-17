//
//  Protocol.swift
//  NotesApp
//
//  Created by Dmitriy Melnichenko on 11/16/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import UIKit

protocol Dismissable { }

extension Dismissable where Self: UIViewController {
    
    func dismiss(completion: (() -> Void)?) {
        if let nav = navigationController {
            nav.popViewController(animated: false)
        } else if let _ = presentationController {
            dismiss(animated: false, completion: nil)
        }
        if completion != nil {
            completion!()
        }
    }
}

protocol Presentable { }

extension Presentable where Self: UIViewController {
    
    func present(viewController: UIViewController) {
        if let nav = navigationController {
            nav.pushViewController(viewController, animated: true)
        } else {
            present(viewController, animated: true, completion: nil)
        }
    }
    
}

