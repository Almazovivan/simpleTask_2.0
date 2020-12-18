//
//  ToDoAssembly.swift
//  ToDoList
//
//  Created by Иван Алмазов on 08.12.2020.
//

import Foundation

class ToDoAssembly {
    var todoModel: ToDoModel {
        let todo = ToDoModel()
        todo.storage = StorageAssembly().diskStrorge
        return todo
    }
}
