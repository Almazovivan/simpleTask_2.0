//
//  AlertServiceImpl.swift
//  ToDoList
//
//  Created by Иван Алмазов on 03.12.2020.
//

import UIKit

class AlertServiceImpl: AlertService {

    var tableViewController: ToDoViewController! // injected
    
    func finishTimer(for cell: ToDoCell) {
        let alert = UIAlertController(title: "Время на задачу вышло", message: nil, preferredStyle: .alert)
        // Блок handler вызывается при нажатии на action1
        let action1 = UIAlertAction(title: "Не сделал", style: .default) { (action) in
            
            // Добавить новую запись
            self.tableViewController.taskDone(isDone: false, cell: cell)
        }
        
        let action2 = UIAlertAction(title: "Готово", style: .cancel) { (action) in
           
            // Добавить новую запись
            self.tableViewController.taskDone(isDone: true, cell: cell)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        tableViewController.present(alert, animated: true, completion: nil)
    }
    
    func runTimer(cell: ToDoCell) {
        let alert = UIAlertController(title: "Начать задачу", message: nil, preferredStyle: .alert)
        // Блок handler вызывается при нажатии на action1
        let action1 = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let action2 = UIAlertAction(title: "Ok", style: .cancel) { (action) in
           
            // Добавить новую запись
            cell.startTimer()
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        tableViewController.present(alert, animated: true, completion: nil)
    }
    
    
    func addItem() {
        let alert = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (texfield) in
            texfield.placeholder = "New Item name"
        }
        
        // Блок handler вызывается при нажатии на action1
        let action1 = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let action2 = UIAlertAction(title: "Ok", style: .cancel) { (action) in
           
            // Добавить новую запись
            guard let newItem = alert.textFields![0].text else {
                return
            }
            self.tableViewController.todo.addItem(nameItem: newItem)
            self.tableViewController.table.reloadData()
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        tableViewController.present(alert, animated: true, completion: nil)
    }
    
    func editItem(nameItem: String, indexItem: Int) {
        
        let alert = UIAlertController(title: "Изменить задачу", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (texfield) in
            texfield.text = nameItem
        }
        
        // Блок handler вызывается при нажатии на action1
        let action1 = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let action2 = UIAlertAction(title: "Ok", style: .cancel) { (action) in
           
            // Добавить новую запись
            guard let newItem = alert.textFields![0].text else {
                return
            }
            self.tableViewController.todo.removeItem(at: indexItem)
            self.tableViewController.todo.toDoItems.insert(Item(name: newItem, isSelected: false), at: indexItem)
            self.tableViewController.table.reloadData()
        }
        alert.addAction(action1)
        alert.addAction(action2)
        tableViewController.present(alert, animated: true, completion: nil)
    }
}
