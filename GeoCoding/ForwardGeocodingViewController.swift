//
//  ForwardGeocodingViewController.swift
//  GeoCoding
//
//  Created by Nathaniel Whittington on 8/11/22.
//

import UIKit
import CoreLocation

class ForwardGeocodingViewController: UIViewController {


    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var locationLabelHide: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var streetTextField: UITextField!
   var geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabelHide.isHidden = true
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        guard let cityText = cityTextField.text else {return}
        guard let streetText = streetTextField.text else {return}
        guard  let countryText = countryTextField.text else {return}
        
        let address = "\(streetText), \(cityText), \(countryText)"
        self.forwardGeocoding(address: address)
        
        
        activityIndicator.startAnimating()
        searchButton.isHidden = true
        dismissKeyboard()
        
    }
    
    func forwardGeocoding(address: String) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
                if error != nil {
                    print("Failed to retrieve location")
                    return
                }
                
                var location: CLLocation?
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    let coordinate = location.coordinate
                    
                    self.searchButton.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.locationLabelHide.isHidden = false
                    self.locationLabel.text = "\(coordinate.latitude), \(coordinate.longitude)"
                }
                else
                {
                    self.locationLabel.text = "No Matching Location Found"
                }
            })
        }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
