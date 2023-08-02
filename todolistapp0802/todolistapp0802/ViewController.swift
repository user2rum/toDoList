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
        let imageView = UIImageView(frame: CGRect(x: 25, y: 132, width: 343, height: 429))
        let image = UIImage(named: "애플")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
    }
    
}
