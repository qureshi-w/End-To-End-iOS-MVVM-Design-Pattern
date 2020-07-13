//
//  ViewController.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: Class Variable
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    
    let viewMode = FoodTruckListViewModel()
    var foodTruckViewModel : [FoodTruckViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constant.Title
        navigationItem.rightBarButtonItem =   UIBarButtonItem(title: Constant.Map, style: .plain, target: self, action: #selector(showMap))
       
        viewMode.delegate = self
        viewMode.fetchFoodTruckList()
    }
    
    
    @objc func showMap(){
        self.performSegue(withIdentifier: Constant.MoveToMapViewSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.MoveToMapViewSegue {
            let mapVC = segue.destination as! MapViewController
            mapVC.foodTrucks = self.foodTruckViewModel
        }
    }
    
    func showAlert(_ title: String, message: String){
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOkay = UIAlertAction(title: Constant.Okay, style: .default, handler: nil)
        let actionCancel = UIAlertAction(title: Constant.Cancel, style: .cancel, handler: nil)
        
        alertVC.addAction(actionOkay)
        alertVC.addAction(actionCancel)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodTruckViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell, for: indexPath) as! FoodTruckDetailCell
        cell.foodTruck = self.foodTruckViewModel[indexPath.row]
        return cell
    }
}

//MARK: FoodTruckViewModelDelegate

extension ViewController: FoodTruckViewModelDelegate {
    
    func updateList(_ foodTruckViewModel : [FoodTruckViewModel]) {
        
        DispatchQueue.main.async { [unowned self] in
            self.foodTruckViewModel = foodTruckViewModel
            self.activityView.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func didFailToFetch(with error: Error) {
        DispatchQueue.main.async { [unowned self] in
            self.activityView.isHidden = true
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.showAlert("Error Alert", message: "Unable to process request this time! ")
        }
    }
}
