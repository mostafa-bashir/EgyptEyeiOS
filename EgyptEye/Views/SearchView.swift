//
//  SearchView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel()
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showActionSheet = false
    
    var body: some View {
        ZStack {
            // bg
            Image("login-bg")
                .resizable()
                .ignoresSafeArea()

            
            VStack(spacing: 50) {
                Spacer()
                
                VStack{
                    VStack(spacing: 0){
                        
                        TextField("Search...", text: $searchViewModel.searchTF)
                            .placeholder(when: searchViewModel.searchTF.isEmpty) {
                                    Text("Search...").foregroundColor(.gray)
                            }
                            .padding()
                            .background(.white.opacity(0.8))
                            
                            .onChange(of: searchViewModel.searchTF) { newValue in
                                searchViewModel.searchByText()
                        }
                        
    //                    if !searchViewModel.landmarks.isEmpty{
                        Group{
                            VStack {
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack {
                                        ForEach(searchViewModel.landmarks, id: \.id) { landmark in
                                            NavigationLink(destination: ResultView(landmarkId: String(landmark.id))) {
                                                Text(landmark.title ?? "")
                                                }
                                        }
                                    }
                                }
                                .padding()
                                .frame(width: UIScreen.main.bounds.width)
                                .background(Color.white.opacity(0.8))
                            }
                        }
                        .opacity((searchViewModel.landmarks.isEmpty || searchViewModel.searchTF.description.isEmpty) ? 0 : 1)
    //                    }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding()
                }
                .padding()
                

                
                
                ZStack {
                     ZStack{
                         
                         
                       
                         
                         if let image = searchViewModel.image {
                             Image(uiImage: image)
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .cornerRadius(10)
                                 .padding()
                                 .background {
                                     RoundedRectangle(cornerRadius: 10)
                                         .fill(Color(hex: "#20595C")!)
                                 }
                                 .onTapGesture {
                                     showActionSheet = true
                                 }
                                 .overlay {
                                     if searchViewModel.isLoading{
                                         ProgressView()
                                             .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                             .padding()
                                     }
                                 }
                         }else{
                             VStack{
                            
                            
                            
                            
                            
                            Image("upload")
                            Text("Upload Image")
                        }
                        .padding()
                        .padding()
                        .padding()
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: "#20595C")!)
                        }
                        .onTapGesture {
                            showActionSheet = true
                        }
                         }
                     }
                    }
                    
                .zIndex(1)
                
                Spacer()
                
                Button {
                    searchViewModel.searchByImage()
                } label: {
                    Text("Find")
                }
                .foregroundColor(.white)
                .padding(20)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "#20595C")!)
                }
                Spacer()
            }
        }
        .overlay {

            if searchViewModel.showingToast{
                VStack {
                    Spacer()
                    ToastView(message: "Couldn't detect this image")
                        .scaledToFit()
                }
            }
        }
        
        
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Choose Source"), buttons: [
                .default(Text("Photo Library"), action: {
                    showImagePicker = true
                    showCamera = false
                }),
                .default(Text("Camera"), action: {
                    showImagePicker = true
                    showCamera = true
                }),
                .cancel()
            ])
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
            ImagePicker(selectedImage: $searchViewModel.image, showCamera: showCamera)
        })
        .background {
            NavigationLink(destination: ResultFromImageView(landmark: searchViewModel.landmarkResult), isActive: $searchViewModel.gotResult) {
                EmptyView()
            }
        }
    }
    
    func loadImage() {
        // Perform any necessary actions after selecting an image
//        nothing here navigation should be after find reponse
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    let showCamera: Bool

    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            
            if showCamera {
                picker.sourceType = .camera
            } else {
                picker.sourceType = .photoLibrary
            }
            
            picker.allowsEditing = false
            return picker
        }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // No need to update the view controller
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

