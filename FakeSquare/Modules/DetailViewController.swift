//
//  DetailViewController.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit
import AddressBook

final class DetailViewController: UIViewController {

    var apiPoi: APIPoi!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberButton: UIButton!
    
    
    let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = apiPoi.title
        addressLabel.text = apiPoi.address
        numberButton.setTitle(apiPoi.tel, forState: UIControlState.Normal)
        
        if let imageUrl = NSURL(string: apiPoi.imageURL) {
            mainImageView.kf_setImageWithURL(imageUrl, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func makeAndAddRecord() {
        let apiRecord: ABRecordRef = ABPersonCreate().takeRetainedValue()
        ABRecordSetValue(apiRecord, kABPersonFirstNameProperty, apiPoi.title, nil)
        
        let phoneNumbers: ABMutableMultiValue =
            ABMultiValueCreateMutable(ABPropertyType(kABMultiStringPropertyType)).takeRetainedValue()
        if let telNumber = apiPoi.tel?.removeWhitespace() {
            ABMultiValueAddValueAndLabel(phoneNumbers, telNumber, kABPersonPhoneMainLabel, nil)
        }
        ABRecordSetValue(apiRecord, kABPersonPhoneProperty, phoneNumbers, nil)
        
        ABAddressBookAddRecord(addressBookRef, apiRecord, nil)
        saveAddressBookChanges()

    }
    
    func saveAddressBookChanges() {
        if ABAddressBookHasUnsavedChanges(addressBookRef){
            var err: Unmanaged<CFErrorRef>? = nil
            let savedToAddressBook = ABAddressBookSave(addressBookRef, &err)
            if savedToAddressBook {
                let contactAddedAlert = UIAlertController(title: "\(apiPoi.title!) was successfully added.",
                                                          message: nil, preferredStyle: .Alert)
                contactAddedAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                presentViewController(contactAddedAlert, animated: true, completion: nil)
            } else {
                print("Couldn't save changes.")
            }
        } else {
            print("No changes occurred.")
        }
    }
    
    func promptForAddressBookRequestAccess(sender: AnyObject) {
        
        ABAddressBookRequestAccessWithCompletion(addressBookRef) { (granted, error) in
            if !granted {
                self.displayCantAddContactAlert()
            } else {
                self.makeAndAddRecord()
            }
        }
        
    }
    
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }

    func displayCantAddContactAlert() {
        let cantAddContactAlert = UIAlertController(title: "Cannot Add Contact",
                                                    message: "You must give the app permission to add the contact first.",
                                                    preferredStyle: .Alert)
        cantAddContactAlert.addAction(UIAlertAction(title: "Change Settings",
            style: .Default,
            handler: { action in
                self.openSettings()
        }))
        cantAddContactAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(cantAddContactAlert, animated: true, completion: nil)
    }


    @IBAction func saveContactButtonClicked(sender: AnyObject) {
        
        
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus {
        case .Denied, .Restricted:
            displayCantAddContactAlert()
        case .Authorized:
            //2
            self.makeAndAddRecord()
        case .NotDetermined:
            //3
            promptForAddressBookRequestAccess(sender)
        }
    }
    
    @IBAction func navigateButtonClicked(sender: AnyObject) {
        let placeMark = MKPlacemark(coordinate: apiPoi.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = apiPoi.title
        mapItem.openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    @IBAction func backButtonClicked(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func numberButtonClicked(sender: UIButton) {
        let phone = "tel://" + apiPoi.tel!.removeWhitespace()
        UIApplication.sharedApplication().openURL(NSURL(string: phone)!)
    }
}
