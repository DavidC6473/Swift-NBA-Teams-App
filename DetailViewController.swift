//
//  DetailViewController.swift
//  IOS_A1_XML
//
//  Created by David Clarke on 14/03/2022.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription! = nil
    var pManageObject : CoreDataEntity! =  nil
    
    var teamData : Team!
    
    func updateBand(){
        
        pManageObject.name = teamLabel.text
        pManageObject.city = cityLabel.text
        pManageObject.conference = conferenceLabel.text
        pManageObject.division = divisionLabel.text
        pManageObject.stadimage = imageName.text
        
   
        do{
            try context.save()
        }catch{
            print("Context cannot save")
        }
        let image = stadImage.image
        if image != nil && imageName != nil{
            putImg2Doc(imageName: stadiumLabel.text!)
        }
    
    }
    
    func saveNewBand(){
        pEntity = NSEntityDescription.entity(forEntityName: "CoreDataEntity", in: context)
        pManageObject = CoreDataEntity(entity: pEntity, insertInto: context)
        
        pManageObject.name = teamLabel.text
        pManageObject.city = cityLabel.text
        pManageObject.conference = conferenceLabel.text
        pManageObject.division = divisionLabel.text
        pManageObject.stadimage = imageName.text
        
        do{
            try context.save()
        }catch{
            print("Context cannot save")
        }
        let image = stadImage.image
        if image != nil && imageName != nil{
            putImg2Doc(imageName: imageName.text!)
        }
    
    }
    
    func getImage(imageName:String){
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        let image = UIImage(named: imageName)
        
        stadImage.image = image
    }
    
    func putImg2Doc(imageName:String){
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        
        let image = stadImage.image
        let data = image?.pngData()
        
        let manager = FileManager.default
        manager.createFile(atPath: imagePath, contents: data, attributes: nil)
        
    }
    
    let pickerController = UIImagePickerController()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        stadImage.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        if pManageObject == nil{
            saveNewBand()
        }else{
            updateBand()
        }
       
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SelectImageAction(_ sender: Any) {
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        pickerController.allowsEditing = false
        
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageName: UILabel!
    
    @IBOutlet weak var teamLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UITextField!
    
    @IBOutlet weak var conferenceLabel: UITextField!
    
    @IBOutlet weak var divisionLabel: UITextField!
    
    @IBOutlet weak var stadiumLabel: UITextField!
    
    @IBOutlet weak var stadImage: UIImageView!
    
    @IBAction func favouriteSwitch(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pManageObject != nil{
            teamLabel.text = pManageObject.name
            cityLabel.text = pManageObject.city
            conferenceLabel.text = pManageObject.conference
            divisionLabel.text = pManageObject.division
            stadiumLabel.text = pManageObject.stadium
            imageName.text = pManageObject.stadimage
            
            
            getImage(imageName: imageName.text ?? "Nil")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue3" {
            let destination = segue.destination as! WebViewController
            
            destination.pManageObject = pManageObject
        }
        if segue.identifier == "segue4" {
            let destination = segue.destination as! RosterViewController
            
            destination.pManageObject = pManageObject
        }
    }

}
