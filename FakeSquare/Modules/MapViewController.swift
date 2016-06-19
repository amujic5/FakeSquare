//
//  MapViewController.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var pois: [APIPoi] = []
    private let _apiManager: APIManager = APIManager()
    private let locationManager: CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        if #available(iOS 9.0, *) {
            mapView.showsCompass = true
        } else {
            // Fallback on earlier versions
        }
        mapView.showsUserLocation = true
        
        
        _apiManager.pois { (pois) in
            self.pois = pois
            self.mapView.addAnnotations(self.pois)
            self.mapView.setRegion(MKCoordinateRegion(center: self.pois[0].coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func locationButtonClicked(sender: UIButton) {
        if let location = locationManager.location {
            mapView.setCenterCoordinate(location.coordinate, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailViewController = segue.destinationViewController as? DetailViewController,
            poi = sender as? APIPoi
            where segue.identifier == String(DetailViewController) {
            detailViewController.apiPoi = poi
            
        }
    }
}

extension MapViewController:  CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = true
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let poi = annotation as? APIPoi {
            let view =  MKPinAnnotationView(annotation: poi, reuseIdentifier: "")
            let button = UIButton(type: .DetailDisclosure)
            
            
            view.rightCalloutAccessoryView = button
            view.canShowCallout = true
            return view
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let poi = view.annotation as? APIPoi {
            performSegueWithIdentifier(String(DetailViewController), sender: poi)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    
    
}