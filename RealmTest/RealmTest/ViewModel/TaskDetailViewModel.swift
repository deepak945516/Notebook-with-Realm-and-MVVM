//
//  TaskDetailViewModel.swift
//  RealmTest
//
//  Created by Deepak Kumar on 30/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import Foundation

final class TaskDetailViewModel: NSObject {
    let database  = RealmDbManager()
    var model = Task()

    func generateUniqueKey(taskName: String) -> String {
        return taskName.dropFirst() + "\(Int(arc4random_uniform(1000)))"
    }

    var createNewModel: Task {
        return Task()
    }
}
