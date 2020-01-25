//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Ankur on 7/4/18.
//  Copyright © 2018 ankur. All rights reserved.
//

import UIKit
import CoreData

open class ViewController: UIViewController {
    
    @IBAction func createData(_ sender: Any) {
        createData()
    }
    
    @IBAction func btnGetAllEntityNameAndKey(_ sender: Any){
        getAllEntityNameAndKey()
    }
    
    @IBAction func retrieveData(_ sender: Any) {
        //retrieveData()
    }
    
    @IBAction func updateData(_ sender: Any) {
        updateData()
    }
    
    @IBAction func deleteData(_ sender: Any) {
        deleteData()
    }
    
    public func createData(){
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        //We need to create a context from this container
        let managedContext = persistentContainer.viewContext
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        for i in 1...5 {
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue("Ankur\(i)", forKeyPath: "username")
            user.setValue("ankur\(i)@test.com", forKey: "email")
            user.setValue("ankur\(i)", forKey: "password")
        }
        //Now we have set all the values. The next step is to save them inside the Core Data
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    public func retrieveData() {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        //We need to create a context from this container
        let managedContext = persistentContainer.viewContext
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //fetchRequest.fetchLimit = 1
        //fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
            }
        } catch {
            print("Failed")
        }
    }
    
    func updateData(){
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        //We need to create a context from this container
        let managedContext = persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue("newName", forKey: "username")
            objectUpdate.setValue("newmail", forKey: "email")
            objectUpdate.setValue("newpassword", forKey: "password")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    }
    
     func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        //We need to create a context from this container
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
       
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    }
    
    func getAllEntityNameAndKey()
    {
        let names = persistentContainer.managedObjectModel.entities.map({ (entity) -> String in
            return entity.name!
        })
        let managedContext = persistentContainer.viewContext
        let _:[[String]]?
        for test in names
        {
//            if String(describing: test) == "User"
//            {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: test))
            //let test = fetchRequest.entity?.attributesByName
           // let arrAttributeTitles = fetchRequest.entity?.attributesByName.enumerated().map { $0.element.key }
            //let arrAttributeTitles = fetchRequest.entity!.attributesByName.enumerated().map { $0.element.key }
            do {
                _ = try managedContext.fetch(fetchRequest)
                let arrAttributeTitles = fetchRequest.entity?.attributesByName.enumerated().map { $0.element.key }
                dump(arrAttributeTitles)
//                for data in result as! [NSManagedObject] {
//                }
            } catch {
               print("Failed")
            }
//            }
        }
        //We need to create a context from this container
        //Prepare the request of type NSFetchRequest  for the entity
    }

    
    lazy var persistentContainer: NSPersistentContainer = {
           /*
            The persistent container for the application. This implementation
            creates and returns a container, having loaded the store for the
            application to it. This property is optional since there are legitimate
            error conditions that could cause the creation of the store to fail.
           */
           let container = NSPersistentContainer(name: "CoreDataCRUD")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   // Replace this implementation with code to handle the error appropriately.
                   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                   /*
                    Typical reasons for an error here include:
                    * The parent directory does not exist, cannot be created, or disallows writing.
                    * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                    * The device is out of space.
                    * The store could not be migrated to the current model version.
                    Check the error message to determine what the actual problem was.
                    */
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()

       // MARK: - Core Data Saving support

       func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   // Replace this implementation with code to handle the error appropriately.
                   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }

}

