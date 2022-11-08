//
//  FactsViewController.swift
//  IOS_A1_XML
//
//  Created by David Clarke on 16/03/2022.
//

import UIKit
import CoreData

class FactsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription! = nil
    var pManageObject : CoreDataEntity! =  nil
    
    var teamData : Team!
    
    func updateBand(){
        
        pManageObject.player = playerLabel.text
        pManageObject.position = positionLabel.text
        pManageObject.draft = draftLabel.text
        pManageObject.dob = dobLabel.text
        pManageObject.playerimage = imageName.text
        
   
        do{
            try context.save()
        }catch{
            print("Context cannot save")
        }
        let image = playerImage.image
        if image != nil && imageName != nil{
            putImg2Doc(imageName: playerLabel.text!)
        }
    
    }
    
    func saveNewBand(){
        pEntity = NSEntityDescription.entity(forEntityName: "CoreDataEntity", in: context)
        pManageObject = CoreDataEntity(entity: pEntity, insertInto: context)
        
        pManageObject.player = playerLabel.text
        pManageObject.position = positionLabel.text
        pManageObject.draft = draftLabel.text
        pManageObject.dob = dobLabel.text
        pManageObject.playerimage = imageName.text
        
        do{
            try context.save()
        }catch{
            print("Context cannot save")
        }
        let image = playerImage.image
        if image != nil && imageName != nil{
            putImg2Doc(imageName: imageName.text!)
        }
    
    }
    
    func getImage(imageName:String){
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        let image = UIImage(named: imageName)
        
        playerImage.image = image
    }
    
    func putImg2Doc(imageName:String){
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        
        let image = playerImage.image
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
        
        playerImage.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    
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
    
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var draftLabel: UITextField!
    @IBOutlet weak var dobLabel: UITextField!
    @IBOutlet weak var heightLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pManageObject != nil{
            playerLabel.text = pManageObject.player
            positionLabel.text = pManageObject.position
            draftLabel.text = pManageObject.draft
            dobLabel.text = pManageObject.dob
            heightLabel.text = pManageObject.height
            imageName.text = pManageObject.playerimage
            
            
            getImage(imageName: imageName.text ?? "Nil")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue6" {
            let destination = segue.destination as! WikiViewController
            
            destination.pManageObject = pManageObject
        }
    }

    

}
