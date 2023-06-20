//
//  File.swift
//  
//
//  Created by Morris Richman on 3/10/23.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)// || os(macOS)
import SwiftUIX

struct stringFilterView: View {
    @Binding var name: String
    @State var remove: (_ String: String) -> Void
    var body: some View {
        HStack {
            Button(action: {
                remove(name)
            }) {
                Image(systemSymbol: .xCircle)
                Text(name)
            }
            .foregroundColor(.white)
            .padding(.trailing)
            .hoverEffect(.highlight)
        }
        .background {
            Capsule(style: .circular)
                .foregroundColor(.gray)
        }
    }
}

#endif
