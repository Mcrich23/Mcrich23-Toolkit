//
//  Filter View.swift
//  Pickt
//
//  Created by Morris Richman on 3/21/22.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)// || os(macOS)
import SwiftUIX

public struct CapsuleMultiFilter: View {
    @Binding var menuContent: AnyView
    @Binding var opt: [String]
    @Binding var selected: [String]
    
    public init(menuContent: Binding<AnyView>, opt: Binding<[String]>, selected: Binding<[String]>) {
        self._menuContent = menuContent
        self._opt = opt
        self._selected = selected
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(selected, id: \.self) { selectedRest in
                    stringFilterView(name: selectedRest) { Rest in
                        let remove = selected.firstIndex(of: Rest)!
                        selected.remove(at: remove)
                    }
                }
                if selected.sorted() != opt.sorted() {
                    Menu(content: {
                        menuContent
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            }
        }
        .frame(height: 20, alignment: .trailing)
        .onAppear {
            print("opt = \(opt)")
        }
    }
}

struct stringFilterView: View {
    @State var name: String
    @State var remove: (_ String: String) -> Void
    var body: some View {
        HStack {
            Button(action: {
                remove(name)
            }) {
                Image(systemName: "x.circle")
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
