//
//  ViewController.swift
//  neversitupTest
//
//  Created by Witawat wanamonthon on 30/1/20.
//  Copyright © 2020 Witawat wanamonthon. All rights reserved.
//

import UIKit

enum itemType {
    case name
    case price
}

class ViewController: UIViewController {

    let itemList = [[itemType.name:"ปากกา",
                     itemType.price:52],
                    [itemType.name:"ตุ๊กตา",
                     itemType.price:500],
                    [itemType.name:"โคมไฟ",
                     itemType.price:590],
                    [itemType.name:"ชอคโกแลต",
                     itemType.price:120],
                    [itemType.name:"เตียง",
                     itemType.price:59000],
                    [itemType.name:"หนังสือ",
                     itemType.price:250]]
    
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var subTotalTextField: UITextField!
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTextFieldInput()
    }

    
    func setupTextFieldInput(){
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressDone))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pressCancel))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        itemTextField.inputAccessoryView = toolBar
        itemTextField.inputView = pickerView
        itemTextField.tintColor = .clear
        subTotalTextField.isUserInteractionEnabled = false
        priceTextField.isUserInteractionEnabled = false
        itemTextField.placeholder = "กรุณาเลือกรายการสินค้า"
        discountTextField.placeholder = "0"
        priceTextField.placeholder = "0"
        subTotalTextField.placeholder = "0"
        discountTextField.delegate = self
    }
    
    @objc func pressDone(){
        itemTextField.resignFirstResponder()
        let item = itemList[pickerView.selectedRow(inComponent: 0)]
        if let price = item[.price] as? Int, let name = item[.name] as? String{
            itemTextField.text = name
            priceTextField.text = "\(price)"
        }
    }
    
    @objc func pressCancel(){
        itemTextField.resignFirstResponder()
    }
    
    
    func calculateValue(){
        if let priceString = priceTextField.text,
            let price = Float(priceString),
            let discountString = discountTextField.text,
            let discount = Float(discountString){
            subTotalTextField.text = "\(price - discount)"
        }
    }

}

extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
         return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculateValue()
    }
}


extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemList[row][.name] as? String ?? ""
    }
    
    
}
