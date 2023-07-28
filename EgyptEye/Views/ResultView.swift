//
//  ResultView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 03/07/2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct ResultView: View {
    
    func openMaps(lat: String, long: String, dest: String) {
        if let lat = CLLocationDegrees(lat), let long = CLLocationDegrees(long) {
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = dest
            
            // You can specify additional options for the map item if needed
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    @StateObject var resultViewModel = ResultViewModel()
    @State private var shouldShowImage = false


    var landmarkId: String
    var body: some View {
        ZStack {
            // bg
            Image("login-bg")
                .resizable()
                .ignoresSafeArea()

            
            
                 ScrollView{
                     VStack{
                    Spacer()
                    VStack{
                        HStack{
                            Text(resultViewModel.result?.title ?? "")
                                .font(.title)
                            Spacer()
                            Button {
                                resultViewModel.addFav(id: String(resultViewModel.result!.id))
                            } label: {
                                Image(systemName: "heart")
                            }
                            .opacity(resultViewModel.removeLike ? 0 : 1)

                        }
                        
                        AsyncImage(url: URL(string: resultViewModel.replaceSpacesInURL())){ image in
                            image
                                .resizable()
                        }placeholder: {
                            Text("Downloading Image...")
                        }
                        


                         


                        Text(resultViewModel.result?.description ?? "")
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.8))
                    }
                    .foregroundColor(Color(hex: "#20595C"))
                .padding(5)
                    
                    Spacer()
                    Button {
                        openMaps(lat: resultViewModel.result?.location?.lat ?? "0", long: resultViewModel.result?.location?.long ?? "0", dest: resultViewModel.result?.title ?? "")

                    } label: {
                        Image("map")
                    }
                    .padding(30)
                }
                
            }
        }
        .onAppear{
            resultViewModel.getResult(id: landmarkId)
        }
    }
       

}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(landmarkId: "1")
    }
}


