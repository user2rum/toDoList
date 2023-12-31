//
//  TodoViewController.swift
//  todolistapp0802
//
//  Created by t2023-m0075 on 2023/08/02.
//

import UIKit

class TodoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
        
    
    @objc func addButtonTapped() {
            let alertController = UIAlertController(title: "할 일 목록", message: "기억 해야 할 일이 있나요?", preferredStyle: .alert)

            alertController.addTextField { (textField) in
                textField.placeholder = "여기에 할 일을 적어주세요"
            }

            // 저장 버튼
            let saveAction = UIAlertAction(title: "저장", style: .default) { [unowned alertController] _ in
                if let textField = alertController.textFields?.first, let text = textField.text {
                    // 텍스트 필드의 값이 비어 있지 않다면 UserDefaults에 저장합니다.
                    if !text.isEmpty {
                        //self.saveTask(task: text)
                    }
                }
               // print(self.tasks)
            }


            // 취소 버튼
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        }
}
