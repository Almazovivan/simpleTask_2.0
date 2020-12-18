//
//  AlertService.swift
//  ToDoList
//
//  Created by Иван Алмазов on 08.12.2020.
//

import UIKit

protocol AlertService {
    func addItem()
    func editItem(nameItem: String, indexItem: Int)
    func runTimer(cell: ToDoCell)
    func finishTimer(for cell: ToDoCell)
}
