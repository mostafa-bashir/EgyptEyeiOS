//
//  MapView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 05/07/2023.
//


import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {

    var lat: CLLocationDegrees
    var long: CLLocationDegrees

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = true
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: span), animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)

        // Add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.mapTapped(_:)))
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // do nothing
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }

    @objc func mapTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let mapView = gestureRecognizer.view as? MKMapView else {
            return
        }

        let locationInView = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)

        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

extension MapView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


