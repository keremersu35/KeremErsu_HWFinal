//
//  CoreDataManager.swift
//  SoundWave
//
//  Created by Kerem Ersu on 14.06.2023.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    
    func save()
    func addTrackToFavorites(track: Track)
    func removeTrackFromFavorites(trackID: Int)
    func isFavorite(trackID: Int) -> Bool
    func getAllFavorites() -> [Favorite]
}

final class CoreDataManager: CoreDataManagerProtocol {
    static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorite")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Failed to save Core Data context: \(error)")
            }
        }
    }

    func addTrackToFavorites(track: Track) {
        
        let favorite = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
        favorite.setValue(track.trackName, forKey: "trackName")
        favorite.setValue(track.artistName, forKey: "artistName")
        favorite.setValue(track.previewURL, forKey: "previewURL")
        favorite.setValue(track.artworkUrl100, forKey: "imageURL")
        favorite.setValue(track.collectionName, forKey: "albumName")
        favorite.setValue(track.trackID, forKey: "trackId")
        
        save()
    }

    func isFavorite(trackID: Int) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorite")
        let predicate = NSPredicate(format: "trackId == %@", NSNumber(value: Int64(trackID)))
        fetchRequest.predicate = predicate
        
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults, results.isEmpty == false {
                return true
            }
        } catch {
            print("\(error)")
        }
        return false
    }

    func removeTrackFromFavorites(trackID: Int) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorite")

        let predicate = NSPredicate(format: "trackId == %@", NSNumber(value: Int64(trackID)))
        fetchRequest.predicate = predicate
        
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                for result in results {
                    context.delete(result)
                }
            }
            save()
        } catch {
            print("Error: Can't get favorites - \(error)")
        }
    }


    func getAllFavorites() -> [Favorite] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites
        } catch {
            print("Error: Can't get favorites - \(error)")
            return []
        }
    }

}

import Foundation
import CoreData

open class CoreDataStack {
  public static let modelName = "Favorite"

  public static let model: NSManagedObjectModel = {
    let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()

  public init() {
  }

  public lazy var mainContext: NSManagedObjectContext = {
    return storeContainer.viewContext
  }()

  public lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  public func newDerivedContext() -> NSManagedObjectContext {
    let context = storeContainer.newBackgroundContext()
    return context
  }

  public func saveContext() {
    saveContext(mainContext)
  }

  public func saveContext(_ context: NSManagedObjectContext) {
    if context != mainContext {
      saveDerivedContext(context)
      return
    }

    context.perform {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }

  public func saveDerivedContext(_ context: NSManagedObjectContext) {
    context.perform {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }

      self.saveContext(self.mainContext)
    }
  }
}

