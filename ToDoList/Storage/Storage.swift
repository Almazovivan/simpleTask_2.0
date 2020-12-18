//
//  File.swift
//  ToDoList
//
//  Created by Иван Алмазов on 01.12.2020.
//

import Foundation

protocol Storage {
    func put (obj: [Item], key: String)
    func get (key: String) -> [Item]?
}
