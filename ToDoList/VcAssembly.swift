//
//  VcAssembly.swift
//  ToDoList
//
//  Created by Иван Алмазов on 08.12.2020.
//

import UIKit

class VcAssembly {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    var toDoViewController: ToDoViewController{
       let vc =  storyboard.instantiateViewController (withIdentifier: "ToDoViewController") as! ToDoViewController
        
        vc.alertService = AlertServiceAssembly().firstAlertService(with: vc)
        vc.todo = ToDoAssembly().todoModel
        
        return vc
    }
}
