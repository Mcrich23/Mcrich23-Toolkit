//
//  Filter View.swift
//  Pickt
//
//  Created by Morris Richman on 3/21/22.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)// || os(macOS)
import SwiftUIX

/**
 A nice multiple filter UI that horizontally scrolls
 
 - parameter menuContent: Passes in the view for the plus button menu. Must use .constant() so that the view updates.
 - parameter opt: Use an array that are the same options as in the menu
 - parameter selected: An array of currently selected filters
 
 # Example #
 ```
 ScrollCapsuleMultiFilter(menuContent: .constant({
         VStack {
             ForEach(viewModel.filterOpt, id: \.self) { text in
                 if !viewModel.filter.contains(text) {
                     Button {
                         viewModel.filter.append(text)
                     } label: {
                         Text(text)
                     }
                 }
             }
         }}), opt: $viewModel.filterOpt, selected: $viewModel.filter)
 ```
 
 */

public struct ScrollCapsuleMultiFilter<Content: View>: View {
    @Binding var menuContent: () -> Content
    @Binding var opt: [String]
    @Binding var selected: [String]
    
    public init(menuContent: Binding<() -> Content>, opt: Binding<[String]>, selected: Binding<[String]>) {
        self._menuContent = menuContent
        self._opt = opt
        self._selected = selected
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(selected, id: \.self) { selectedItem in
                    stringFilterView(name: Binding(get: {
                        return selectedItem
                    }, set: {_ in})) { item in
                        let remove = selected.firstIndex(of: item)!
                        selected.remove(at: remove)
                    }
                }
                if Array(Set(opt)).sorted() != (selected.sorted()) {
                    Menu(content: {
                        menuContent()
                    }, label: {
                        Image(systemSymbol: .plusCircle)
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
#endif
