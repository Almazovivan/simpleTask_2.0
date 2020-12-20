//
//  VcAssembly.swift
//  ToDoList
//
//  Created by Иван Алмазов on 08.12.2020.
//

import UIKit
import EasyDi

//class VcAssembly {
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//    var toDoViewController: ToDoViewController{
//       let vc =  storyboard.instantiateViewController (withIdentifier: "ToDoViewController") as! ToDoViewController
//
//        vc.alertService = AlertServiceAssembly().firstAlertService(with: vc)
//        vc.todo = ToDoAssembly().todoModel
//
//        return vc
//    }
//}

class VcAssembly: Assembly {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    var toDoViewController: ToDoViewController{
        
        return define(init: self.storyboard.instantiateViewController (withIdentifier: "ToDoViewController") as! ToDoViewController) {
      
        
//            $0.alertService = AlertServiceAssembly().firstAlertService(with: self.toDoViewController)
            $0.todo = self.todo
        }
    }
    
    var todo: ToDoModel {
        return define(init: ToDoAssembly().todoModel)
    }
}
