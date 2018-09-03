//
//  Task.swift
//  RealmTest
//
//  Created by Deepak Kumar on 29/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import Foundation
import RealmSwift

final class Task: Object {
    @objc dynamic var taskName: String =  ""
    @objc dynamic var taskDetail: String = ""
    @objc dynamic var ID = ""
    override class func primaryKey() -> String? {
        return "ID"
    }
}

final class TaskList {
    var taskList: [Task] = []
}
