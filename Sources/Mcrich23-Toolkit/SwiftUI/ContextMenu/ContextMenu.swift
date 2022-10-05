//
//  ContextMenu.swift
//  Easy Bridge Tracker
//
//  Created by Morris Richman on 9/7/22.
//

import Foundation
import SwiftUI

public struct PreviewContextMenu<Content: View> {
    public let destination: Content
    public let actionProvider: UIContextMenuActionProvider?
    public let navigate: PreviewContextMenuNavigate
    
    public init(navigate: PreviewContextMenuNavigate, destination: Content, menu: @escaping () -> UIMenu) {
        self.navigate = navigate
        self.destination = destination
        self.actionProvider = { _ in return menu()}
    }
}

public enum PreviewContextMenuNavigate {
    case expand
    case custom(() -> Void)
}

// UIView wrapper with UIContextMenuInteraction
struct PreviewContextView<Content: View>: UIViewRepresentable {
    
    let menu: PreviewContextMenu<Content>
    let didCommitView: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let menuInteraction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addInteraction(menuInteraction)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(menu: self.menu, didCommitView: self.didCommitView)
    }
    
    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        
        let menu: PreviewContextMenu<Content>
        let didCommitView: () -> Void
        
        init(menu: PreviewContextMenu<Content>, didCommitView: @escaping () -> Void) {
            self.menu = menu
            self.didCommitView = didCommitView
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
                UIHostingController(rootView: self.menu.destination)
            }, actionProvider: self.menu.actionProvider)
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
            animator.addCompletion(self.didCommitView)
        }
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
            let parameters = UIPreviewParameters()
            parameters.backgroundColor = .clear
            return UITargetedPreview(view: interaction.view!, parameters: parameters)
        }

        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
            let parameters = UIPreviewParameters()
            parameters.backgroundColor = .clear
            return UITargetedPreview(view: interaction.view!, parameters: parameters)
        }
        
    }
}

// Add context menu modifier
extension View {
    public func contextMenu<Content: View>(_ menu: PreviewContextMenu<Content>) -> some View {
        self.modifier(PreviewContextViewModifier(menu: menu))
    }
}

public struct PreviewContextViewModifier<V: View>: ViewModifier {
    
    let menu: PreviewContextMenu<V>
    @Environment(\.presentationMode) var mode
    
    @State var isActive: Bool = false
    
    public func body(content: Content) -> some View {
        Group {
            if isActive {
                switch menu.navigate {
                case .custom(let action):
                    content
                        .onAppear {
                            action()
                        }
                case .expand:
                    menu.destination
                }
            } else {
                content.overlay(PreviewContextView(menu: menu, didCommitView: { self.isActive = true }))
            }
        }
    }
}
