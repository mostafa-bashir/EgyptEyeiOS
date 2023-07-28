//
//  TabBarView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    var body: some View {
 
        TabView(selection: $selectedTab) {
            NavigationView {
                SearchView()
            }

               .tabItem {
                   if selectedTab == 0{
                       Image("search")
                           .frame(width: 25, height: 25)
                   }else{
                       Image("search-inactive")
                           .frame(width: 25, height: 25)
                   }
                   Text("Search")
               }

            .tag(0)
                   
            NavigationView{
                ProfileView()
            }
           .tabItem {
               Image(systemName: "person")
               Text("Profile")
           }
       .tag(1)
            
               }
        .accentColor(Color(hex: "#20595C"))

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
