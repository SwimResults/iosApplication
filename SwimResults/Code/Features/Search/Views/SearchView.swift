//
//  SearchView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct SearchView: View {
    @State var query = ""
    
    var body: some View {
        VStack{
            Form {
                TextField("Suche", text: $query)
            }
            Spacer()
            Divider()
            Text("Hier suchen!!")
            Text("Sportler-, Vereins- und Streckensuche")
        }
    }
}

#Preview {
    SearchView()
}
