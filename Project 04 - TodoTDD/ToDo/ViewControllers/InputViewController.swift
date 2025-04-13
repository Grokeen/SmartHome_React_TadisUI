//
//  InputViewController.swift
//  ToDo
//
//  Created by Yi Gu on 5/4/19.
//  Copyright © 2019 gu, yi. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
  
  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var locationTextField: UITextField!
  @IBOutlet var descriptionTextField: UITextField!
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var cancelButton: UIButton!
  @IBOutlet var saveButton: UIButton!
  
  lazy var geocoder = CLGeocoder()
  var itemManager: ToDoItemManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
//  +버튼 눌렀을 때 동작 1번
    titleTextField.delegate = self
    locationTextField.delegate = self
    descriptionTextField.delegate = self
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  @IBAction func save() {
    guard let titleString = titleTextField.text,
      titleString.count > 0 else {
        return
    }
    
//      저장버튼 눌렀을 때 동작 1번 -> 아마 에러인듯
    // datePicker could be nil if the view controller is init via code
    var date: Date?
    if datePicker != nil {
      date = datePicker.date
    }
    
      //      저장버튼 눌렀을 때 동작 2번 -> 아마 에러인듯
    // descriptionTextField could be nil if the view controller is init via code
    var descriptionString: String?
    if descriptionTextField != nil {
      descriptionString = descriptionTextField.text
    }
      //      저장버튼 눌렀을 때 동작 3번 -> 아마 에러인듯
    // locationTextField could be nil if the view controller is init via code
    var placeMark: CLPlacemark?
    var locationName: String?
    
    if locationTextField != nil {
      locationName = locationTextField.text
      if let locationName = locationName, locationName.count > 0 {
        geocoder.geocodeAddressString(locationName) { [weak self] placeMarks, _ in
          placeMark = placeMarks?.first
          
          let item = ToDoItem(title: titleString,
                              itemDescription: descriptionString,
                              timeStamp: date?.timeIntervalSince1970,
                              location: Location(name: locationName, coordinate: placeMark?.location?.coordinate))
          
          DispatchQueue.main.async {
            self?.itemManager?.add(item)
            self?.dismiss(animated: true)
          }
        }
      } else {
        let item = ToDoItem(title: titleString,
                            itemDescription: descriptionString,
                            timeStamp: date?.timeIntervalSince1970,
                            location: nil)
        self.itemManager?.add(item)
        dismiss(animated: true)
      }
    } else {
      let item = ToDoItem(
        title: titleString,
        itemDescription: descriptionString,
        timeStamp: date?.timeIntervalSince1970)
      
      self.itemManager?.add(item)
      dismiss(animated: true)
    }
  }
  
  @IBAction func cancel() {
    dismiss(animated: true, completion: nil)
  }
}

extension InputViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignFirstResponder()
    view.endEditing(true)
    return false
  }
}

