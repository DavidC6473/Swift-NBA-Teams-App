//
//  PersonViewController.swift
//  IOS_A1_XML
//
//  Created by David Clarke on 17/04/2022.
//

import UIKit
import CoreData

class PersonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription! = nil
    var pManageObject : CoreDataEntity! =  nil
    
    func updateBand(){
        
        pManageObject.name = nameLabel.text
        pManageObject.abreviation = abreviationLabel.text
        pManageObject.logo = imageName.text
        pManageObject.isFavourited = favouriteSwitch.isOn
        
   
        do{
            try context.save()
        }catch{
            print("Context cannot save")
        }
        
        let image = logoImage.image
        if image != nil && imageName != nil{
            putImg2Doc(imageName: imageName.text!)
        }
    }
    
    func saveNewBand(){
        pEntity = NSEntityDescription.entity(forEntityName: "CoreDataEntity", in: context)
        pManageObject = CoreDataEntity(entity: pEntity, insertInto: context)
        
        
        pManageObject.name = nameLabel.text
        pManageObject.abreviation = abreviationLabel.text
        pManageObject.logo = imageName.text
        pManageObject.isFavourited = favouriteSwitch.isOn
        
        
        do{
            try context.save()
        }catch{
            print("Context cannot save")
        }
        let image = logoImage.image
        if image != nil && imageName != nil{
            putImg2Doc(imageName: imageName.text!)
        }
    
    }
    
    func getImage(imageName:String){
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        let image = UIImage(named: imageName)
        
        logoImage.image = image
    }
    
    func putImg2Doc(imageName:String){
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        
        let image = logoImage.image
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
        
        logoImage.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var nameLabel: UITextField!
    
    
    var teamData : Team!
    
    
    @IBOutlet weak var abreviationLabel: UITextField!
    
    
    @IBOutlet weak var favouriteSwitch: UISwitch!
    
  
    @IBOutlet weak var imageName: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    
    @IBAction func selectImageAction(_ sender: Any) {
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        pickerController.allowsEditing = false
        
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if pManageObject == nil{
            saveNewBand()
        }else{
            updateBand()
        }
       
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pManageObject != nil{
            nameLabel.text = pManageObject.name
            abreviationLabel.text = pManageObject.abreviation
            imageName.text = pManageObject.logo
            favouriteSwitch.isOn = pManageObject.isFavourited
            
            getImage(imageName: imageName.text ?? "Nil")
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue2" {
            let destination = segue.destination as! DetailViewController
            
            destination.pManageObject = pManageObject
        }
        if segue.identifier == "segue5" {
            let destination = segue.destination as! FactsViewController
            
            destination.pManageObject = pManageObject
        }
    }
    

}

