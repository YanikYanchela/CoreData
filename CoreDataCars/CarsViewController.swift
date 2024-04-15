import UIKit

class CarsViewController: UIViewController {
    
    var car: Car?
    // Создаем текстовые поля для ввода данных
    let brandTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Brand"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let modelTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Model"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Year"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let engineCapacityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Engine Capacity"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Чтение объекта
        if let car = car {
            brandTextField.text = car.brand
            modelTextField.text = car.model
            yearTextField.text = String(car.year)
            engineCapacityTextField.text = String(car.engine)
        }
        
        view.backgroundColor = .white
        self.title = "Create Car"
        
        // Добавляем текстовые поля на экран
        view.addSubview(brandTextField)
        view.addSubview(modelTextField)
        view.addSubview(yearTextField)
        view.addSubview(engineCapacityTextField)
        
        setupLayout()
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeModalView))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createCar))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
    }
    
  
    // Функция для установки расположения текстовых полей на экране
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [brandTextField, modelTextField, yearTextField, engineCapacityTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    // фуникция сохрания
    func saveCar() -> Bool {
        if brandTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Input error", message: "Please fill in the blanks", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            return false
        }
        // Создаем объект
        if car == nil {
            car = Car()
        }
        // Сохраняем обьект
        if let car = car {
            car.brand = brandTextField.text
            car.model = modelTextField.text
            car.year = Int16(yearTextField.text!)!
            car.engine = Double(engineCapacityTextField.text!)!
            CoreDataManager.shared.saveContext()
        }
        return true
    }
    
    @objc func closeModalView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func createCar() {
        if saveCar() {
            dismiss(animated: true, completion: nil)
        }
    }
    
   
}




    
 
