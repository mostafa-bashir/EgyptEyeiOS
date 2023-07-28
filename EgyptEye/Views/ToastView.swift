//
//  ToastView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 06/07/2023.
//

import SwiftUI

struct ToastView: View {
    var message: String
    
    var body: some View {

                
        VStack {
            Text(message)
                .foregroundColor(.white)
                .padding(5)
        }
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.5))
        }

    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "das")
    }
}
