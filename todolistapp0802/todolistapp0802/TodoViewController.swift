//
//  TodoViewController.swift
//  todolistapp0802
//
//  Created by t2023-m0075 on 2023/08/02.
//

import UIKit

class TodoViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    
    var task: [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        loadData()

    }
    
    
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "할 일 목록", message: "할 일을 적어주세요.", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "내용을 입력해주세요."
        }
        
        // 저장 버튼
        let saveAction = UIAlertAction(title: "저장", style: .default) { [unowned alertController] _ in
            if let textField = alertController.textFields?.first, let text = textField.text {
                // 텍스트 필드의 값이 비어 있지 않다면 UserDefaults에 저장합니다.
                if !text.isEmpty {
                    self.task.append(text)
                    self.tableView.reloadData()
                }
                
              print(self.task)
                
            }
        }
        
        // 취소 버튼
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let task = self.task[indexPath.row]
            cell.textLabel?.text = task
            
            return cell
        
    }
    
    // 셀 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.task.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.task.isEmpty {
            
        }
    }
    
    // 테이블뷰 셀 수정
    func modifyTask(at index: Int, newTask: String) {
            if index >= 0 && index < task.count {
                task[index] = newTask
                tableView.reloadData()
                saveData()
            } else {
                print("Invalid index: \(index)")
            }
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "할 일 수정", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = self.task[indexPath.row]
        }
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [unowned alertController] _ in
            if let textField = alertController.textFields?.first, let text = textField.text {
                // 텍스트 필드의 값이 비어 있지 않다면 수정한 내용으로 셀을 업데이트합니다.
                if !text.isEmpty {
                    self.modifyTask(at: indexPath.row, newTask: text)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    func saveData() {
        UserDefaults.standard.set(self.task, forKey: "tasks")
    }
    
    // 데이터를 UserDefaults에서 불러오는 함수
    func loadData() {
        if let savedTasks = UserDefaults.standard.array(forKey: "tasks") as? [String] {
            self.task = savedTasks
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveData()
    }

}

