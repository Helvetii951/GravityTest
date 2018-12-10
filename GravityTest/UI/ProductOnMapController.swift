//
//  ProductOnMapController.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import UIKit
import MapKit

class ProductOnMapController: UIViewController {
    
    var productViewModel : ProductViewModel!
    
    var mapView : MKMapView!
    
    override func viewDidLoad() {
        setUpMap()
        addProductToMap()
    }
    
    func setUpMap() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
//        mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func addProductToMap() {
        let annotaion = MKPointAnnotation()
        annotaion.title = productViewModel.title
        annotaion.subtitle = productViewModel.description
        let coordinate = CLLocationCoordinate2D(latitude: productViewModel.lat, longitude: productViewModel.lon)
        annotaion.coordinate = coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.addAnnotation(annotaion)
        mapView.setRegion(region, animated: true)
    }
}

