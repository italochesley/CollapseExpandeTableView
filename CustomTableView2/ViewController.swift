//
//  ViewController.swift
//  CustomTableView2
//
//  Created by Italo Chesley on 6/7/16.
//  Copyright © 2016 Italo Chesley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableTeams: UITableView!
    var teams: [Team] = []
    var selectedSection: Int = -1
    var previousSelectedsection: Int = -1
    
    var myCustomerView: CustomerTableUiView = CustomerTableUiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teams = loadInitialData()
        self.tableTeams.separatorColor = UIColor.clearColor()
        
        tableTeams.registerNib(UINib(nibName: "Cell", bundle: nil ), forCellReuseIdentifier: "Cell")
        tableTeams.registerNib(UINib(nibName: "header", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderCell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return teams.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSection == section {
            return teams[section].Employees.count
        }else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? CustomerTableUiView
        
        if cell != nil {
        
        cell!.customerRole.text = teams[indexPath.section].Employees[indexPath.row].Role
        cell!.customerName.text = teams[indexPath.section].Employees[indexPath.row].Name
        }else
        {
            print("nulo")
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HeaderCell") as! CustomHeaderUiView
        
        cell.nameLabel.text = teams[section].Name
        cell.nameLabel.tag = section
        cell.nameLabel.textColor = UIColor.blueColor()
        
        if section == selectedSection {
            cell.statusLabel.text = "Aberto"
        }else
        {
            cell.statusLabel.text = "Fechado"
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        cell.userInteractionEnabled = true
        cell.addGestureRecognizer(tap)
        cell.tag = section
        
        return cell
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if let selectedTag = sender.view?.tag {
            previousSelectedsection = selectedSection
            selectedSection = Int(selectedTag)
            let nsIndexPath1 = NSIndexSet(index: selectedSection)
            let nsIndexPath2 = NSIndexSet(index: previousSelectedsection)
            
            tableTeams.beginUpdates()
            //quando vai zabrir a primeira
            if previousSelectedsection == -1 && selectedSection != -1 {
                tableTeams.reloadSections(nsIndexPath1, withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            //só produz o movimento quando alguma celular ja esta aberta
            if previousSelectedsection != -1 {
                //quando vai abrir uma abaixo da que esta aberta
                if selectedSection > previousSelectedsection {
                    tableTeams.reloadSections(nsIndexPath2, withRowAnimation: UITableViewRowAnimation.Fade)
                    tableTeams.reloadSections(nsIndexPath1, withRowAnimation: UITableViewRowAnimation.Fade)
                }
                //quando vai abrir uma acima da que esta aberta
                if selectedSection < previousSelectedsection {
                    tableTeams.reloadSections(nsIndexPath1, withRowAnimation: UITableViewRowAnimation.Fade)
                    tableTeams.reloadSections(nsIndexPath2, withRowAnimation: UITableViewRowAnimation.Fade)
                }
            }
            
            //quando vai fechar a que esta aberta
            if selectedSection == previousSelectedsection {
                selectedSection = -1
                previousSelectedsection = -1
                tableTeams.reloadSections(nsIndexPath1, withRowAnimation: UITableViewRowAnimation.Fade)
            }
            tableTeams.endUpdates()
            
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teams[section].Name
    }
    
    func loadInitialData() -> [Team]
    {
        let teamJson: NSURL = [#FileReference(fileReferenceLiteral: "teams.json")#]
        let data = NSData(contentsOfURL: teamJson)!
        
        var newTeams: [Team] = []
        
        do
        {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            if let teams = json["Teams"] as? [[String: AnyObject]]
            {
                for team in teams
                {
                    var newEmployees: [Employee] = []
                    if let employees = team["Employees"] as? [[String:AnyObject]]
                    {
                        for employee in employees
                        {
                            var employeeName: String?
                            var employeeRole: String?
                            if let name = employee["Name"] as? String
                            {
                                employeeName = name
                            }
                            
                            if let role = employee["Role"] as? String
                            {
                                employeeRole = role
                            }
                            
                            newEmployees.append(Employee(Name: employeeName, Role: employeeRole))
                        }
                    }
                    
                    var teamName: String?
                    
                    if let name = team["Name"] as? String
                    {
                        teamName = name
                    }
                    
                    newTeams.append(Team(Name: teamName!, Employees: newEmployees))
                }
            }
        }catch
        {
            print("Erros serializing JSON")
        }
        
        return newTeams
    }
    


}

