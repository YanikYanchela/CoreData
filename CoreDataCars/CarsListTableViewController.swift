//
//  CarsListTableViewController.swift
//  CoreDataCars
//
//  Created by Дмитрий Яновский on 8.04.24.
//

import UIKit
import CoreData

class CarsListTableViewController: UITableViewController {
    
    struct Constant {
        static let nameTable = "Cars List"
        static let entity = "Car"
        static let sortBrand = "brand"
        static let cellName = "Cell"
        static let identifierCarsView = "navController"
    }
    
    var navController = UINavigationController()
    
    var fetchResultController = CoreDataManager.shared.fetchResultController(entityName: Constant.entity, sortName: Constant.sortBrand)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // подписываем таблицу на протокол
        fetchResultController.delegate = self
        self.title = Constant.nameTable
        navigationController?.navigationBar.prefersLargeTitles = true
        // выборка данных из БД
        inputDataBase()
        // Регистрируем ячейку для использования в таблице
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellName)
        setupAddButton()
        // Удаление линий в таблице
        tableView.tableFooterView = UIView()
   
    }
    // MARK: - Setup UI
    func setupAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
    }
    
    func inputDataBase() {
        // выборка данных из БД
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
    @objc func addButtonTap() {
       
        let CarVC = CarsViewController()
        navController = UINavigationController(rootViewController: CarVC)
        navController.modalPresentationStyle = .pageSheet
        present(navController, animated: true)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellName, for: indexPath)
     
         let car = fetchResultController.object(at: indexPath) as! Car
         cell.textLabel?.text = "\(car.brand ?? "") \(car.model ?? "")"

     
     return cell
     }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = fetchResultController.object(at: indexPath) as! Car
        
         let CarVC = CarsViewController()
         CarVC.car = car
         navController = UINavigationController(rootViewController: CarVC)
         navController.modalPresentationStyle = .pageSheet
         present(navController, animated: true)
        
        
        
    }
  
     // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = fetchResultController.object(at: indexPath) as! Car
            CoreDataManager.shared.context.delete(car)
            CoreDataManager.shared.saveContext()
            
        }
    }
    
}

extension CarsListTableViewController: NSFetchedResultsControllerDelegate {
    // метод информирует о начале изминения данных
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let car = fetchResultController.object(at: indexPath) as! Car
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = "\(car.brand ?? "") \(car.model ?? "")"
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
        
    
    //метод информирует об окончании изменении данных
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}













// Создание обьекта
//        let managedObject = Car()
//Запись атрибутов
//        managedObject.brand = "Lamborgini"
//        managedObject.model = "Huracan"
//        managedObject.year = 2023
//        managedObject.engine = 5.2
// Сохранение данных
//        CoreDataManager.shared.saveContext()
//        // Изылечение данных
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
//        do {
//            let results = try CoreDataManager.shared.context.fetch(fetchRequest)
//            for result in results as! [Car] {
//                print("\(result.model) \(result.brand) \(result.year) \(result.engine)")
//            }
//        } catch {
//            print(error)
//        }
// Удаление всех записей
//        do {
//            let results = try CoreDataManager.shared.context.fetch(fetchRequest)
//            for result in results as! [NSManagedObject] {
//                CoreDataManager.shared.context.delete(result)
//            }
//        } catch {
//            print(error)
//        }
//        // Сохранить
//        CoreDataManager.shared.saveContext()
