//
//  ViewController.swift
//  chrisras-pset4
//
//  Created by Christopher Ras on 23/11/2016.
//  Copyright © 2016 Chris Ras. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!
    
    private let db = DatabaseHelper()
    var tasks = [String]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if db == nil{
            print("error")
        } else {
            do {
                try tasks = db!.readFromDB()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! TaskCellTableViewCell
        
        cell.taskLabel.text = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            //tasks.remove(at: indexPath.row)
            do {
                try db!.deleteFromDB(task: tasks[indexPath.row])
                //tasks.remove(at: indexPath.row)
                try tasks = db!.readFromDB()
            } catch {
                print(error)
            }
            tableView.reloadData()
            //tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        if taskTextField.text != nil && taskTextField.text != "" {
            //tasks.append(taskTextField.text!)
            do {
                try db!.addToDB(entry: taskTextField.text!)
                try tasks = db!.readFromDB()
            } catch {
                print(error)
            }
            tableView.reloadData()
        }
    }


}

