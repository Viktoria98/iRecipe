//
//  HomeView.swift
//  iRecipe
//
//  Created by Viktoria Kryvosheeva on 28.03.2021.
//

import Foundation
import Combine
import SwiftUI

struct HomeView: View {
    
    @State var userName: String
    @State var userEmail: String
    
    var onSignOut: (() -> ())
    
    var body: some View {
        
        Text(userName)
        Text(userEmail)
        
        Button(action: { onSignOut() }) {
            Text("Sign Out")
        }
    }
    
}
