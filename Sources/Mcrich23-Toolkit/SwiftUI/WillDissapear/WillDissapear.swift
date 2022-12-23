//
//  File.swift
//  
//
//  Created by Morris Richman on 10/5/22.
//

import Foundation
import SwiftUI

public struct WillDisappearHandler: UIViewControllerRepresentable {
    public func makeCoordinator() -> WillDisappearHandler.Coordinator {
        Coordinator(onWillDisappear: onWillDisappear)
    }

    public let onWillDisappear: () -> Void

    public func makeUIViewController(context: UIViewControllerRepresentableContext<WillDisappearHandler>) -> UIViewController {
        context.coordinator
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WillDisappearHandler>) {
    }

    public typealias UIViewControllerType = UIViewController

    public class Coordinator: UIViewController {
        public let onWillDisappear: () -> Void

        public init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

public struct WillDisappearModifier: ViewModifier {
    public let callback: () -> Void

    public func body(content: Content) -> some View {
        content
            .background(WillDisappearHandler(onWillDisappear: callback))
    }
}

extension View {
    /**
     Run code when the view will dissapear, but before it actually dissapears.
     
     - parameter perform: Run code here.
     
     # Example #
     ```
        var body: some View {
            Text("This view has dissapeared     \(viewModel.dissapearCount)     times!")
            .onWillDissapear {
                viewModel.dissapearCount += 1
            }
        }
     ```
     
     */
    public func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(WillDisappearModifier(callback: perform))
    }
}
