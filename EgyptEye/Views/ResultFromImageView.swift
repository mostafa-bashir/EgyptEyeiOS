//
//  ResultFromImageView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 05/07/2023.
//

import SwiftUI
import CoreLocation
import MapKit


struct ResultFromImageView: View {
    
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

    @State var landmark: LandmarkResult?

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
                            Text(landmark?.title ?? "")
                                .font(.title)
                            Spacer()
                           
                            Button{
                                resultViewModel.addFav(id: String(resultViewModel.result?.id ?? 0))
                            } label: {
                                Image(systemName: "heart")
                            }
                            .opacity(resultViewModel.removeLike ? 0 : 1)


                        }
                        
                        AsyncImage(url: URL(string: self.replaceSpacesInURL(url: landmark?.image?.image ?? ""))){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)

                        }placeholder: {
                            Text("Downloading Image...")
                        }

                        Text(landmark?.description ?? "")
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(1))
                    }
                    .foregroundColor(Color(hex: "#20595C"))
                .padding(5)
                    
                    Spacer()
                    Button {
                        openMaps(lat: landmark?.location?.lat ?? "0", long: landmark?.location?.long ?? "0", dest: landmark?.title ?? "")
                    } label: {
                        Image("map")
                    }
                    .padding(30)
                }
                
            }
        }
        
    }
       

}

struct ResultFromImageView_Previews: PreviewProvider {
    static var previews: some View {
        ResultFromImageView(landmark: LandmarkResult(id: 2, title: "df", description: "dad", imageID: 12, locationID: 213, createdAt: "s", updatedAt: "d", image: ImageLandmark(id: 23, image: "dd", createdAt: "we", updatedAt: "ds"), location: Location(id: 3, long: "ds", lat: "ds", createdAt: "ds", updatedAt: "d")))
    }
}


extension ResultFromImageView{
    func replaceSpacesInURL(url: String) -> String {
        let replacedString = url.replacingOccurrences(of: " ", with: "%20")
        return replacedString
    }
}
