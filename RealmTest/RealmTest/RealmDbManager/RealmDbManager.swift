//
//  RealmDbManager.swift
//  RealmTest
//
//  Created by Deepak Kumar on 29/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmDbManager {
    let database: Realm = try! Realm()

    func getDataFromDb() -> Results<Task> {
        let result: Results<Task> = database.objects(Task.self)
        return result
    }

    func addDataToDb(object: Task) {
        try! database.write {
            database.add(object)
        }
    }

    func deleteFromDb(object: Task) {
        try! database.write {
            database.delete(object)
        }
    }

    func updateTask(task: Task) {
        try! database.write {
            database.add(task, update: true)
        }
    }

    func deleteAllFroDb() {
        try! database.write {
            database.deleteAll()
        }
    }
}
