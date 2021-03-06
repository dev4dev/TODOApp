//
//  TaskStore.swift
//  TODOApp
//
//  Created by Pepas Personal on 7/19/15.
//  Copyright (c) 2015 Pepas Personal. All rights reserved.
//

import Foundation

protocol TaskStoreProtocol
{
    func addTask(taskTitle: String)
    func tasksCount() -> Int
    func taskTitleAtIndex(index: Int) -> String?
    func deleteTaskAtIndex(index: Int)
}

extension Array
{
    func get(index: Int) -> Element?
    {
        if index < 0 || index >= self.count
        {
            return nil
        }
        else
        {
            return self[index]
        }
    }
}

class InMemoryTaskStore: TaskStoreProtocol
{
    private var tasks: [String] = [String]()
    
    func addTask(taskTitle: String)
    {
        tasks.append(taskTitle)
    }
    
    func tasksCount() -> Int
    {
        return count(tasks)
    }
    
    func taskTitleAtIndex(index: Int) -> String?
    {
        return tasks.get(index)
    }
    
    func deleteTaskAtIndex(index: Int)
    {
        tasks.removeAtIndex(index)
    }
}

class NSUserDefaultsTaskStore: TaskStoreProtocol
{
    init()
    {
        tasks = _loadTasksFromDisk()
    }
    
    func addTask(taskTitle: String)
    {
        tasks.append(taskTitle)
        _writeTasksToDisk()
    }
    
    func tasksCount() -> Int
    {
        return count(tasks)
    }
    
    func taskTitleAtIndex(index: Int) -> String?
    {
        return tasks.get(index)
    }

    func deleteTaskAtIndex(index: Int)
    {
        tasks.removeAtIndex(index)
        _writeTasksToDisk()
    }
    
    private var tasks: [String] = [String]()
    
    private let _tasksNSUserDefaultsKey: String = "_tasksNSUserDefaultsKey"
    
    private func _loadTasksFromDisk() -> [String]
    {
        if var tasks = NSUserDefaults.standardUserDefaults().arrayForKey(_tasksNSUserDefaultsKey) as? [String]
        {
            return tasks
        }
        else
        {
            return [String]()
        }
    }
    
    private func _writeTasksToDisk()
    {
        NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: _tasksNSUserDefaultsKey)
    }
}

