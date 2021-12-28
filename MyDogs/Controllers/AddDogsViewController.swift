//
//  AddDogsViewController.swift
//  MyDogs
//
//  Created by admin on 24/05/1443 AH.
//

import UIKit
import CoreData
class AddDogsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var dogNameTf: UITextField!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var dogColorTf: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addDogButton: UIButton!
    
    @IBOutlet weak var dogFavoriteTreatTf: UITextField!
    
    // MARK: - Var
    var dog: Dog?
    
    
    // MARK: - CoreData Vars
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        deleteButton.isHidden = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        editData()
    }
    
    // MARK: - Add Data
    func addData(){
        if let dog = dog {
            dog.dogName = dogNameTf.text
            dog.dogColor = dogColorTf.text
            dog.dogFavoriteTreat = dogFavoriteTreatTf.text
            dog.dogImage = imageView.image?.jpegData(compressionQuality: 1)
        }
        else{
            
            let myDog = Dog(context: context)
            myDog.dogName = dogNameTf.text
            myDog.dogColor = dogColorTf.text
            myDog.dogFavoriteTreat = dogFavoriteTreatTf.text
            myDog.dogImage = imageView.image?.jpegData(compressionQuality: 1)
            do{
                try context.save()
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Edit Data
    func editData(){
        if let dog = dog {
            dogNameTf.text = dog.dogName
            self.title = dog.dogName
            
            dogColorTf.text = dog.dogColor
            dogFavoriteTreatTf.text = dog.dogFavoriteTreat
            
            if let imageData = dog.dogImage{
                imageView.image = UIImage(data: imageData)
            }
            deleteButton.isHidden = false
            addDogButton.setTitle("Update Dog Details", for: .normal)
            addPhotoButton.setTitle("Change Photo", for: .normal)
        }
    }
    //MARK: - Import Picture
    func importPicture() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Delete Data
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if let dog = dog {
            
            context.delete(dog)
            
            do{
                try context.save()
                self.navigationController?.popViewController(animated: true)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addPhotoPressed(_ sender: UIButton) {
        importPicture()
    }
    
    @IBAction func addDogPressed(_ sender: UIButton) {
        addData()
    }
    
}

// MARK: - Picker Extension
extension AddDogsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
