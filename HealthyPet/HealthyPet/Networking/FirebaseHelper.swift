//
//  FirebaseHelper.swift
//  HealthyPet
//
//  Created by Kristina Motte on 13/09/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseCore
import PromiseKit

protocol AddNewAnimal {
    func addNew(animal: Animal, _ completion: @escaping (Error?) -> Void)
    func uploadImage(image: UIImage, id: String, completion: @escaping (Error?, String?) -> Void)
}

protocol AllAnimals {
    func getAllAnimals() -> Promise<[Animal]>
    func getImageUrl(id: String, path: String, completion: @escaping (URL?) -> Void)
}

final class FirebaseHelper: AddNewAnimal, AllAnimals {
    let ref = Database.database().reference()
    let storageRef = Storage.storage().reference()
    var dataBaseHandler: DatabaseHandle?
    
    func addNew(animal: Animal, _ completion: @escaping (Error?) -> Void) {
        let data = [
            "id": animal.id,
            "imageUrl": animal.imageUrl,
            "petName": animal.petName,
            "animalType": animal.animalType,
            "breed": animal.breed,
            "birthday": animal.birthday,
            "gender": animal.gender,
            "ownerName": animal.ownerName,
            "ownerNumber": animal.ownerNumber
        ] as [String: String?]
        
        ref.child("pets/\(animal.id)").setValue(data) { error, _ in
            completion(error)
        }
    }
    
    func delete(animal: Animal, _ completion: @escaping (Error?) -> Void) {
        ref.child("pets/\(animal.id)").setValue(nil) { error, _ in
            completion(error)
        }
    }
    
    func edit(animal: Animal, _ completion: @escaping (Error?) -> Void) {
        let data = [
            "id": animal.id,
            "imageUrl": animal.imageUrl as Any,
            "petName": animal.petName,
            "animalType": animal.animalType,
            "breed": animal.breed,
            "birthday": animal.birthday,
            "gender": animal.gender,
            "ownerName": animal.ownerName,
            "ownerNumber": animal.ownerNumber
        ] as [String: Any]
        
        ref.child("pets/\(animal.id)").updateChildValues(data) { error, _ in
            completion(error)
        }
    }
    
    func getAllAnimals(_ completion: @escaping ([Animal]) -> Void) {
        dataBaseHandler = ref.observe(DataEventType.value, with: { snapshot in
            if let dict = snapshot.value as? NSDictionary, let values = dict["pets"] as? NSDictionary {
                var animals: [Animal] = []
                
                for item in values {
                    let key = item.key
                    let value = item.value as? NSDictionary
                    let id = key as? String ?? ""
                    let imageUrl = value?["imageUrl"] as? String
                    let petName = value?["petName"] as? String ?? ""
                    let animalType = value?["animalType"] as? String ?? ""
                    let breed = value?["breed"] as? String ?? ""
                    let birthday = value?["birthday"] as? String ?? ""
                    let gender = value?["gender"] as? String ?? ""
                    let ownerName = value?["ownerName"] as? String ?? ""
                    let ownerNumber = value?["ownerNumber"] as? String ?? ""
                    let animal = Animal(id: id, imageUrl: imageUrl, petName: petName, animalType: animalType, breed: breed, birthday: birthday, gender: gender, ownerName: ownerName, ownerNumber: ownerNumber)
                    animals.append(animal)
                }
                
                completion(animals)
            } else {
                completion([])
            }
        })
    }
    
    func getAllAnimals() -> Promise<[Animal]> {
        Promise { seal in
            getAllAnimals { animals in
                DataCache.cacheIfPossible(animals, forKey: .pets)
                
                seal.fulfill(animals)
            }
        }
    }
    
    func uploadImage(image: UIImage, id: String, completion: @escaping (Error?, String?) -> Void) {
        guard let jpegData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let path = "/images/\(id).jpg"
        let fileRef = storageRef.child(path)
        
        _ = fileRef.putData(jpegData) { metadata, error in
            guard let error = error, metadata == nil else {
                completion(nil, path)
                return
            }
            
            completion(error, nil)
        }
    }
    
    func getImageUrl(id: String, path: String, completion: @escaping (URL?) -> Void) {
        let starsRef = storageRef.child(path)

        // Fetch the download URL
        starsRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(nil)
                return
            }
            
            let model = FirebaseImage(id: id, url: url)
            DataCache.cacheIfPossible(model, forKey: .firebaseImage, identifier: id)
            
            completion(url)
        }
    }
}
