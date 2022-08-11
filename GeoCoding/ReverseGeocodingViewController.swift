//
//  BackwardGeocodingViewController.swift
//  GeoCoding
//
//  Created by Nathaniel Whittington on 8/11/22.
//

import UIKit
import CoreLocation

class ReverseGeocodingViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var latTextField: UITextField!
    
    @IBOutlet weak var locationLabelHide: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var longTextField: UITextField!
    var geoCoder = CLGeocoder()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabelHide.isHidden = true
    }
    
   

    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        
        guard let latText = latTextField.text, let latString = Double(latText) else {return}
        guard let longText = longTextField.text, let longString = Double(longText) else {return}
        
        
        self.getAddressFromLatLon(pdblLatitude: latString, withLongitude: longString)
        
        // Update View
        
        searchButton.isHidden = true
        activityIndicator.startAnimating()
        dismissKeyboard()
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
           
        
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat = pdblLatitude
         
            let lon = pdblLongitude
   
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                        self.searchButton.isHidden = false
                        self.activityIndicator.stopAnimating()
                        self.locationLabelHide.isHidden = false
                        self.locationLabel.text = addressString
                  }
            })

        }
    
}
