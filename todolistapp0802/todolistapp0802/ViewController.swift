//
//  ViewController.swift
//  todolistapp0802
//
//  Created by t2023-m0075 on 2023/08/02.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 25, y: 132, width: 343, height: 429)) //사진 띄우기
        let image = UIImage(named: "애플")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
    }
    
    @IBAction func toDoButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toDoList", sender: sender) //todolist 버튼
        
        }
        
   
    @IBAction func doneButton(_ sender: UIButton) {
        performSegue(withIdentifier: "doneList", sender: sender) //donelist 버튼
        
    }
}

