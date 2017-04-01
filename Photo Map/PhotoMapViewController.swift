//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PhotoMapViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate {
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        //print(latitude, longitude)
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        annotation.coordinate = locationCoordinate
        annotation.title = "\(latitude)"
        mapView.addAnnotation(annotation)
    }


    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var cameraButton: UIButton!
    let picker = UIImagePickerController()
    
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // One degree of latitude is approximately 111 kilometers (69 miles) at all times.
        // San Francisco Lat, Long = latitude: 37.783333, longitude: -122.416667
        let mapCenter = CLLocationCoordinate2D(latitude: 37.779560, longitude:-122.393027)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        // Set animated property to true to animate the transition to the region
        mapView.setRegion(region, animated: false)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPin() {
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: 37.779560, longitude: -122.393027)
        annotation.coordinate = locationCoordinate
        annotation.title = "Founders Den"
        mapView.addAnnotation(annotation)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        pickedImage = originalImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
          performSegue(withIdentifier: "tagSegue", sender: self)
    }
    
    
    
    @IBAction func onCameraButtonClick(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let locationsViewController = segue.destination as! LocationsViewController
        locationsViewController.delegate = self
    }
    

}
