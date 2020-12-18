//
//  AlertServiceAssembly.swift
//  ToDoList
//
//  Created by Иван Алмазов on 08.12.2020.
//

import UIKit

class AlertServiceAssembly {
    func firstAlertService (with vc: ToDoViewController) -> AlertService {
        let alertService = AlertServiceImpl()
        alertService.tableViewController = vc
        return alertService
    }
}
