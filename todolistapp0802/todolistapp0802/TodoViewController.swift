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
           
           // 변경 3: 데이터를 먼저 로드한 후 테이블 뷰를 다시 로드합니다.
           loadData()
           tableView.reloadData()
       }
       
       @objc func addButtonTapped() {
           let alertController = UIAlertController(title: "할 일 목록", message: "할 일을 적어주세요.", preferredStyle: .alert)
           
           // 변경 4: 간소화된 코드 스타일
           alertController.addTextField { textField in
               textField.placeholder = "내용을 입력해주세요."
           }
           
           // 변경 6: 간소화된 조건문
           let saveAction = UIAlertAction(title: "저장", style: .default) { [unowned alertController] _ in
               if let textField = alertController.textFields?.first, let text = textField.text, !text.isEmpty {
                   self.task.append(text)
                   self.tableView.reloadData()
               }
           }
           
           let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
           
           alertController.addAction(saveAction)
           alertController.addAction(cancelAction)
           
           present(alertController, animated: true, completion: nil)
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.task.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           cell.textLabel?.text = task[indexPath.row]
           
           // 변경 5: 스위치의 초기화를 간소화합니다.
           let switchView = UISwitch(frame: .zero)
           switchView.isOn = false
           switchView.tag = indexPath.row
           switchView.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
           
           cell.accessoryView = switchView
           
           return cell
       }
       
       @objc func switchValueChanged(_ sender: UISwitch) {

           let rowIndex = sender.tag
           let isSwitchOn = sender.isOn


           if sender.isOn {

               self.task.remove(at: sender.tag)
               tableView.reloadData()
           }
       }
   
       
       // 변경 7: 삭제 로직을 수행하기 전에 editingStyle이 .delete인지 확인합니다. 드래그 해서 삭제
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               self.task.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .automatic)
           }
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let alertController = UIAlertController(title: "할 일 수정", message: nil, preferredStyle: .alert)
           
           alertController.addTextField { textField in
               textField.text = self.task[indexPath.row]
           }
           
           let saveAction = UIAlertAction(title: "저장", style: .default) { [unowned alertController] _ in
               if let textField = alertController.textFields?.first, let text = textField.text, !text.isEmpty {
                     self.modifyTask(at: indexPath.row, newTask: text)
               }
           }
           
           let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
           
           alertController.addAction(saveAction)
           alertController.addAction(cancelAction)
           
           present(alertController, animated: true, completion: nil)
           
           tableView.deselectRow(at: indexPath, animated: true)
       }
       
       func modifyTask(at index: Int, newTask: String) {
           if index >= 0 && index < task.count {
               task[index] = newTask
               saveData()
           } else {
               print("Invalid index: \(index)")
           }
       }
       
       func saveData() {
           UserDefaults.standard.set(self.task, forKey: "tasks")
       }
       
       func loadData() {
           if let savedTasks = UserDefaults.standard.array(forKey: "tasks") as? [String] {
               self.task = savedTasks
           }
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           saveData()
       }
   }
