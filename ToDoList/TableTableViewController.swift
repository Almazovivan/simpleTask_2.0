////
////  TableTableViewController.swift
////  ToDoList
////
////  Created by Иван Алмазов on 30.11.2020.
////
//
//import UIKit
//
//
//
//class TableTableViewController: UITableViewController, UIGestureRecognizerDelegate {
//
//    let todo = ToDoModel()
//    var alertDelegate: ToDoAlertDelegate?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        alertDelegate = AlertService()
//        setupLongPressGesture()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return todo.toDoItems.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let item = todo.toDoItems[indexPath.row]
//        cell.textLabel?.text = item.name
//        
//        // MARK: Ставим галочку
//        if item.isSelected {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        // Снимаем выделение по нажатию
//        tableView.deselectRow(at: indexPath, animated: true)
//        todo.changeState(at: indexPath.row)
//        
//        if todo.toDoItems[indexPath.row].isSelected {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//    }
//    
//    // Таблица в режим редактирования
//    @IBAction func edit(_ sender: Any) {
//        
//        tableView.setEditing(!tableView.isEditing, animated: true)
//    }
//    
//      // MARK: - Добавить новую запись
//    @IBAction func addItem(_ sender: Any) {
//        alertDelegate?.addItem(tableViewController: self)
//    }
//    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            todo.removeItem(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//
//
//  // MARK: -  Меняем местами записи
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        todo.moveItem(from: fromIndexPath.row, to: to.row)
//    }
//    
//    
//    func setupLongPressGesture() {
//        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        longPressGesture.minimumPressDuration = 1.0 // 1 second press
//        longPressGesture.delegate = self
//        self.tableView.addGestureRecognizer(longPressGesture)
//    }
//
//    @objc func test(recogn: UILongPressGestureRecognizer!){
//        print("123")
//    }
//    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer!){
//        if tableView.isEditing {
//            if gestureRecognizer.state == .began {
//                let touchPoint = gestureRecognizer.location(in: self.tableView)
//                if let indexPath = tableView.indexPathForRow(at: touchPoint) {
//
//                    let text = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""
//                    alertDelegate?.editItem(tableViewController: self, nameItem: text, indexItem: indexPath.row)
//                }
//            }
//        }
//    }
//
//}
//
