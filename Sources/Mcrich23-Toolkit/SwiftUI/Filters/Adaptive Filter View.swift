//
//  File.swift
//  
//
//  Created by Morris Richman on 3/10/23.
//

import SwiftUI
import WrappingHStack

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)// || os(macOS)
import SwiftUIX

/**
 A nice multiple filter UI that auto resizes
 
 - parameter label: The label you want next to the capsule filters
 - parameter menuContent: Passes in the view for the plus button menu. Must use .constant() so that the view updates.
 - parameter opt: Use an array that are the same options as in the menu
 - parameter selected: An array of currently selected filters
 
 # Example #
 ```
 AdaptiveCapsuleMultiFilter("Filter: ", menuContent: .constant({
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
public struct AdaptiveCapsuleMultiFilter<Content: View>: View {
    @Binding var menuContent: () -> Content
    @Binding var opt: [String]
    @Binding var selected: [String]
    let label: String
    
    public init(_ label: String, menuContent: Binding<() -> Content>, opt: Binding<[String]>, selected: Binding<[String]>) {
        self.label = label
        self._menuContent = menuContent
        self._opt = opt
        self._selected = selected
    }
    
    public var body: some View {
        if selected.isEmpty {
            HStack {
                Text(label)
                Menu(content: {
                    menuContent()
                }, label: {
                    Image(systemSymbol: .plusCircle)
                })
            }
        } else {
            WrappingHStack(0..<(selected.count + 2), id: \.self) { index in
                HStack {
                    if index > 0 && index != (selected.count + 1) {
                        let selectedItem = selected[(index - 1)]
                        stringFilterView(name: Binding(get: {
                            return selectedItem
                        }, set: {_ in})) { item in
                            if let remove = selected.firstIndex(of: item) {
                                selected.remove(at: remove)
                            }
                        }
                    } else {
                        if index == 0 {
                            Text(label)
                        }
                        if Array(Set(opt)).sorted() != (selected.sorted()) && (index != 0 || selected.count == 0) {
                            Menu(content: {
                                menuContent()
                            }, label: {
                                Image(systemSymbol: .plusCircle)
                            })
                        }
                    }
                }
                .fixedSize()
                .padding(.bottom, 3)
            }
        }
    }
}
#endif
