//
//  MapViewController.swift
//  FoodTruck
//
//  Created by Waqar Qureshi on 08/07/2020.
//  Copyright © 2020 Waqar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblOpenTime: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var foodTrucks : [FoodTruckViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.Title
        navigationItem.rightBarButtonItem =   UIBarButtonItem(title: Constant.List, style: .plain, target: self, action: #selector(goOnPreviousScreen))
        navigationItem.hidesBackButton = true
        mapView.delegate = self
        self.preparePins()
        self.zoomedToFitAllPins()
    }
    
    func preparePins() {
        
        for foodTruck in foodTrucks {
            let pin = MKPointAnnotation()
            pin.title = foodTruck.applicantName
            pin.subtitle = foodTruck.address
            let longitude = foodTruck.longitude
            let latitude = foodTruck.latitude
            pin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.mapView.addAnnotation(pin)
        }
    }
    
    
    func zoomedToFitAllPins() {
        
        var zoomRect = MKMapRect.null
        for annotation in mapView.annotations {
            
            let annotationPoint = MKMapPoint(annotation.coordinate)
            
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
            
            if (zoomRect.isNull) {
                zoomRect = pointRect
            } else {
                zoomRect = zoomRect.union(pointRect)
            }
        }
        
        self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }
    
    @objc func goOnPreviousScreen(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let latitude = view.annotation?.coordinate.latitude
        let longitude = view.annotation?.coordinate.longitude
        
        let foodTruck =  foodTrucks.filter({
            $0.longitude == longitude && $0.latitude == latitude
        })[0]
        
        self.lblName.text = foodTruck.applicantName
        self.lblAdress.text = foodTruck.address
        self.lblDescription.text = foodTruck.description
        self.lblOpenTime.text = foodTruck.openTime
    }
}
