//
//  Task.swift
//  todolistapp0802
//
//  Created by t2023-m0075 on 2023/08/02.
//

import Foundation

struct Task {
    var title: String // 할일 내용 저장
    var done: Bool // 할일이 완료 되었는지 여부 저장
    init(title: String, done: Bool) {
            self.title = title
            self.done = done
        }
}
