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
    
    @IBOutlet weak var regionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchforSegmentedControl: UISegmentedControl!
    
    let topPickerData = Array(1..<10)
    let bottomPickerData = Array(1..<10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topPicker.dataSource = self
        topPicker.delegate = self
        
        bottomPicker.dataSource = self
        bottomPicker.delegate = self
//        
//        regionSegmentedControl.addTarget(self, action: "action:", forControlEvents: .ValueChanged)
//        searchforSegmentedControl.addTarget(self, action: "action:", forControlEvents: .ValueChanged)
    }
    
    @IBAction func regionChanged(sender: AnyObject) {
        if (regionSegmentedControl.selectedSegmentIndex == 0) {
            SearchState.sharedManager().searchType = "US"
        } else {
            SearchState.sharedManager().searchType = "UK"
        }
    }
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        if (searchforSegmentedControl.selectedSegmentIndex == 0) {
            SearchState.sharedManager().searchType = "shows"
        } else {
            SearchState.sharedManager().searchType = "movies"
        }
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
            return String(topPickerData[row])
        } else if (pickerView == bottomPicker) {
            return String(bottomPickerData[row])
        }
        return "No data found. Try refreshing."
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == topPicker) {
            SearchState.sharedManager().indexOfWhereToStart = pickerView.selectedRowInComponent(component)+1
        } else if (pickerView == bottomPicker) {
            SearchState.sharedManager().numberOfResultsToShow = pickerView.selectedRowInComponent(component)+1
        }
        
        print(" \(SearchState.sharedManager().indexOfWhereToStart)")
        print(" \(SearchState.sharedManager().numberOfResultsToShow)")
    }
    
    
}