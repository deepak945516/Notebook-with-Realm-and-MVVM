//
//  ViewModel.swift
//  RealmTest
//
//  Created by Deepak Kumar on 29/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import Foundation

final class ViewModel: NSObject {
    var model = TaskList()
    let database: RealmDbManager = RealmDbManager()
    func numberOfRowsAtSection(section: Int) -> Int {
        return model.taskList.count
    }

    func getCellData(atIndex index: Int) -> Task {
        return model.taskList[model.taskList.count - 1 - index]
    }

    func loadDataFromDb() {
        model.taskList = Array(database.getDataFromDb())
    }

    func deleteData(atIndex index: Int) {
        database.deleteFromDb(object: model.taskList[index])
        loadDataFromDb()
    }
}
