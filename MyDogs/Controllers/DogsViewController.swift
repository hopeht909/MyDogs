//
//  ViewController.swift
//  MyDogs
//
//  Created by admin on 24/05/1443 AH.
//

import UIKit
import CoreData

class DogsViewController: UICollectionViewController {
    
    // MARK: - Vars
    var dogs: [Dog] = []

    // MARK: - CoreData Vars
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dogs"
        context = appDelegate.persistentContainer.viewContext
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            fetchData()
        }
   
    // MARK: - Add Dogs
    @IBAction func addDogsButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addDogsVC = storyboard.instantiateViewController(withIdentifier: "AddDogsViewController") as! AddDogsViewController
        self.navigationController?.pushViewController(addDogsVC, animated: true)
    }
    
    // MARK: - Fetch data
    func fetchData(){
        let fetchRequest = NSFetchRequest<Dog>(entityName: "Dog")
        
        do{
            dogs = try context.fetch(fetchRequest)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    // MARK: - CollectionView DataSource, Delegate
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCell", for: indexPath) as! DogCell
        
        let item = dogs[indexPath.row]
        cell.dogName.text = item.dogName
        
        if let imageData = item.dogImage{
            cell.dogImage.image = UIImage(data: imageData)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addDogsVC = storyboard.instantiateViewController(withIdentifier: "AddDogsViewController") as! AddDogsViewController
        
        addDogsVC.dog = dogs[indexPath.row]
        
        self.navigationController?.pushViewController(addDogsVC, animated: true)
    }

}

