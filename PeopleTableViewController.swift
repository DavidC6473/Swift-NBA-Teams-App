//
//  PeopleTableViewController.swift
//  IOS_A1_XML
//
//  Created by David Clarke on 17/04/2022.
//

import UIKit
import CoreData

class PeopleTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
  
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    var nbaData = [Nba]()
    
    private var showFavourite = false
    private var predicate : NSPredicate?
    
    // show favourited items button
    @IBAction func showFavourites(_ sender: Any) {
        showFavourite = !showFavourite
       
        if !showFavourite {
            predicate = nil
        } else {
            predicate = NSPredicate(format: "isFavourited == %@", NSNumber(value: showFavourite))
        }
        
        favouriteButton.isSelected = !favouriteButton.isSelected
        tableView.reloadData()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription! = nil
    var pManageObject : CoreDataEntity! =  nil
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    
    
    // make request function
    func makeRequest()->NSFetchRequest<NSFetchRequestResult>{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataEntity")
        let sorter = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sorter]
        
        return request
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do{
            try frc.performFetch()
        }catch{
            print("FRC cannot fetch")
        }
        
        if frc.sections![0].numberOfObjects == 0{
            nbaData = [Nba]()
            let xmlData = Nba(xmlFileName: "nba_teams.xml").nbaData
            
            for team in xmlData{
                pEntity = NSEntityDescription.entity(forEntityName: "CoreDataEntity", in: context)
                pManageObject = CoreDataEntity(entity: pEntity, insertInto: context)
                
                pManageObject.name = team.name
                pManageObject.abreviation = team.abreviation
                pManageObject.city = team.city
                pManageObject.conference = team.conference
                pManageObject.division = team.division
                pManageObject.logo = team.logo
                pManageObject.stadium = team.stadium
                pManageObject.stadimage = team.stadimage
                pManageObject.webteam = team.webteam
                pManageObject.webroster = team.webroster
                pManageObject.player = team.player
                pManageObject.playerimage = team.playerimage
                pManageObject.position = team.position
                pManageObject.dob = team.dob
                pManageObject.height = team.height
                pManageObject.playerweb = team.playerweb
                pManageObject.draft = team.draft
                pManageObject.isFavourited = showFavourite
                
                putImg2Doc(name: team.logo)
            }
            
            do{
            try context.save()
            }catch{}
        }
    }
    
    func fetchEntitiesWith() -> [Nba] {
        nbaData.removeAll()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "team")
        request.predicate = predicate
        let sorter = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sorter]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
         do{
             try frc.performFetch()
         }catch{
             print("frc cannot fetch")
         }
        
        if let teamsFetched = frc.sections![0].objects as? [Nba] {
            nbaData.append(contentsOf: teamsFetched)
        }
        
        return nbaData
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
        pManageObject = frc.object(at: indexPath) as? CoreDataEntity
                
        cell.textLabel?.text = pManageObject.name;
                
        let image = getImage(imageName: pManageObject.logo ?? "AppIcon.png")
        print(pManageObject.logo ?? "AppIcon.png")
                
        cell.imageView?.image = image
                
        return cell
    }
    
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            predicate = NSPredicate(format: "name contains %@", searchText)
        } else if showFavourite && !searchText.isEmpty {
            predicate = NSPredicate(format: "name contains %@ AND isFavourited == %@", searchText, NSNumber(value: showFavourite))
        } else if showFavourite {
            predicate = NSPredicate(format: "isFavourited == %@", NSNumber(value: showFavourite))
        } else {
            predicate = nil
        }
        tableView.reloadData()
    }

    func getImage(imageName:String)->UIImage!{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        return UIImage(contentsOfFile: imagePath)
         
    }
    
    func putImg2Doc(name:String) {
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let imagePath = documentsPath.appendingPathComponent(name)
            
            let image = UIImage(named: name)
            let data = image?.pngData()
            
            let manager = FileManager.default
            manager.createFile(atPath: imagePath, contents: data, attributes: nil)
        }
  

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            pManageObject = frc.object(at: indexPath) as? CoreDataEntity
  
            context.delete(pManageObject)
            
            tableView.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue1"{
            let destination = segue.destination as! PersonViewController
        
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            pManageObject = frc.object(at: indexPath!) as? CoreDataEntity
            
            destination.pManageObject = pManageObject
        
        }
        if segue.identifier == "segue2"{
            let destination = segue.destination as! PersonViewController
        
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            pManageObject = frc.object(at: indexPath!) as? CoreDataEntity
            
            destination.pManageObject = pManageObject
        
        }
    }
}



