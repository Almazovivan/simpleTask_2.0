//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Иван Алмазов on 04.12.2020.
//

import UIKit



class ToDoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var todo: ToDoModel! // injected
    var alertService: AlertService! // injected


    @IBOutlet weak var table: UITableView!
    @IBOutlet var collectionButton: [UIButton]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        // убирвю пустые ячейки
        table.tableFooterView = UIView(frame: .zero)
        // настройка долгого нажатия на ячейку
        setupLongPressGesture()
    }
    
    // Таблица в режим редактирования
    @IBAction func edit(_ sender: Any) {
        
        table.setEditing(!table.isEditing, animated: true)
    }
    
      // MARK: - Добавить новую запись
    @IBAction func addItem(_ sender: Any) {
        alertService?.addItem()
    }
    
    // MARK: - Сменить день
    var indexOfLastButton: Int = 0
    @IBAction func changeDay(_ sender: UIButton) {
        
        let indexButton = collectionButton.firstIndex(of: sender)
        sender.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        collectionButton[indexOfLastButton].titleLabel?.font = UIFont.systemFont(ofSize: 14)
        indexOfLastButton = indexButton!
        
        todo.day = sender.title(for: .normal)!
        table.reloadData()
    }
    

}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoCell
        let item = todo.toDoItems[indexPath.row]
//        cell.textLabel?.text = item.name
        cell.nameTask.text = item.name
        cell.alert = alertService
        cell.indexRow = indexPath.row
        
        // MARK: Ставим галочки
        if item.isSelected {
            cell.isDone.image = UIImage.init(named: "done")
        } else {
            cell.isDone.image = UIImage.init(named: "notDone")
        }
        


        return cell
    }
    
      // MARK: - Нажали на ячейку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Снимаем выделение по нажатию
        tableView.deselectRow(at: indexPath, animated: true)
        todo.changeState(at: indexPath.row)
        
        let cell = tableView.cellForRow(at: indexPath) as! ToDoCell
        
        if !cell.timerIsRunning {
            alertService.runTimer(cell: cell)
        }
        
//        if todo.toDoItems[indexPath.row].isSelected {
//            
////            cell.isDone.image = UIImage.init(named: "done")
////        } else {
////            cell.isDone.image = UIImage.init(named: "notDone")
//        }
    }
    
    func taskDone(isDone: Bool, cell: ToDoCell) {
        if isDone {
            cell.isDone.image = UIImage.init(named: "done")
            todo.toDoItems[cell.indexRow].isSelected = true
            table.reloadData()
           
        } else {
            cell.isDone.image = UIImage.init(named: "notDone")
            todo.toDoItems[cell.indexRow].isSelected = false
            table.reloadData()
        }
    }
    
    // MARK: - Удаляем ячейку у таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todo.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }
    }
    
    // MARK: -  Меняем местами записи
      // Override to support rearranging the table view.
      func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
          todo.moveItem(from: fromIndexPath.row, to: to.row)
          table.reloadData()
      }
    
    // MARK: - Устанавливае GestureRecognizer (долгое нажатие)
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.table.addGestureRecognizer(longPressGesture)
    }
    // MARK: - Если таблица в режиме редактирования, выводить алерт с полем
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer!){
        if table.isEditing {
            if gestureRecognizer.state == .began {
                let touchPoint = gestureRecognizer.location(in: self.table)
                if let indexPath = table.indexPathForRow(at: touchPoint) {

                    guard let cell = table.cellForRow(at: indexPath) as? ToDoCell else {return}
                    let text = cell.nameTask.text ?? ""
                    alertService?.editItem(nameItem: text, indexItem: indexPath.row)
                }
            }
        }
    }

    
}
