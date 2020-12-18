//
//  ToDoModel.swift
//  ToDoList
//
//  Created by Иван Алмазов on 30.11.2020.
//

import Foundation

struct Item: Codable {
    var name: String
    var isSelected: Bool = false
    
}

class ToDoModel {
    var storage: Storage!
    
    var day: String = "Пн"
    
    // MARK: - Массив. При обращении читает из стореджа. При добавлении записывает в сторедж
    var toDoItems: [Item] {
        set {
            storage.put(obj: newValue, key: day)
        }
        
        get {
            guard let items = storage.get(key: day) else {
                return []
            }
            return items
        }
    }
    
     // MARK: - Добавить запись
    func addItem(nameItem: String) {
        toDoItems.append(Item(name: nameItem))
    }
    
     // MARK: - Удалить по индексу
    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
    }
    
    // MARK: - Меняем состояние для галочки
    func changeState(at item: Int) {
        toDoItems[item].isSelected = !toDoItems[item].isSelected
    }
    
    func moveItem(from: Int, to: Int) {
        let movebleItem = toDoItems[from]
        toDoItems.remove(at: from)
        toDoItems.insert(movebleItem, at: to)
    }
}
