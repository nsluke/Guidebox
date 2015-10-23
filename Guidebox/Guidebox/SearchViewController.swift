//
//  SearchViewController.swift
//  Guidebox
//
//  Created by Luke Solomon on 10/20/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    
    @IBOutlet weak var topPicker: UIPickerView!
    @IBOutlet weak var bottomPicker: UIPickerView!
    
    
    let topPickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    
    let bottomPickerData = ["5","10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topPicker.dataSource = self
        topPicker.delegate = self
        
        bottomPicker.dataSource = self
        bottomPicker.delegate = self
    }
    
    
    
}

extension SearchViewController: UIPickerViewDataSource {
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView == topPicker) {
            return topPickerData.count

        } else if (pickerView == bottomPicker) {
            return bottomPickerData.count
        }
        return 0
    }
}

extension SearchViewController: UIPickerViewDelegate {
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == topPicker) {
            return topPickerData[row]
        } else if (pickerView == bottomPicker) {
            return bottomPickerData[row]
        }
        return "No data found. Try refreshing."
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == topPicker) {
            //do something
        } else if (pickerView == bottomPicker) {
            //do something else
        }
    }
    
    
}