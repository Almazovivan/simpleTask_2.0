//
//  StorageImpl.swift
//  ToDoList
//
//  Created by Иван Алмазов on 01.12.2020.
//

import Foundation

class DiskStorage: Storage {
    
    var storage = UserDefaults.standard
    func put(obj: [Item], key: String) {
        do {
            let data = try JSONEncoder().encode(obj)
            storage.set(data, forKey: key)
        }
        catch let error {
            print(error)
        }
        storage.synchronize()
    }
    
    func get(key: String) -> [Item]? {
        
        guard let data = storage.object(forKey: key) as? Data else {
            return []
        }
        var item: [Item] = []
        
        do {
            item = try JSONDecoder().decode([Item].self, from: data)
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
        return item
    }
    
}
