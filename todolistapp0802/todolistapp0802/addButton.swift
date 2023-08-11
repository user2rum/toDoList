//
//  addButton.swift
//  todolistapp0802
//
//  Created by t2023-m0075 on 2023/08/02.
//

import UIKit

class AddButton: UIButton{
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton(){
        setTitle("Add", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .blue
        addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped(){
        showAddTodoAlert()
    }
    
    private func showAddTodoAlert(){
        let alertController = UIAlertController(title: "ㅅ", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in textField.placeholder = "Enter your Todo"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let newTodo = textField.text, !newTodo.isEmpty{
                print("New Todo: \(newTodo)")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alertController.addAction(addAction)
                alertController.addAction(cancelAction)

                // AddButton 클래스는 UIView를 상속하므로 view의 최상위 컨트롤러를 사용하여 알림창을 띄웁니다.
                if let viewController = self.firstAvailableViewController() {
                    viewController.present(alertController, animated: true, completion: nil)
                }
    }
}

extension UIView {
    func firstAvailableViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let currentResponder = responder {
            if let viewController = currentResponder as? UIViewController {
                return viewController
            }
            responder = currentResponder.next
        }
        return nil
    }
}

