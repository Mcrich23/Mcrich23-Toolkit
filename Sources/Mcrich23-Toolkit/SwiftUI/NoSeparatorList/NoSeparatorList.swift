//
//  NoSeparatorList.swift
//  Pickt
//
//  Created by Morris Richman on 12/19/22.
//

import Foundation
import SwiftUI

public struct NoSeparatorList<Content: View>: View {
  public let content: () -> Content

  public init(_ content: @escaping () -> Content) {
    self.content = content
  }

  public var body: some View {
    if #available(iOS 15.0, *) {
      List {
        content()
          .listRowSeparator(.hidden)
      }
    } else if #available(iOS 14.0, *) {
      ScrollView {
        LazyVStack {
          content()
        }
      }
    } else {
        List {
            content()
        }
        .onAppear {
          UITableView.appearance().separatorStyle = .none
        }.onDisappear {
          UITableView.appearance().separatorStyle = .singleLine
        }
    }
  }
}
