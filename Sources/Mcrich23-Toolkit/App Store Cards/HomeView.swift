//
//  HomeView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI
import SwiftUIX

let screen = UIScreen.main.bounds

public struct CardView: View {
    @ObservedObject var control = TicketCardView_Control()
    @State var showHeader: ShowHeader
    //change cardData to real tickets
    @Binding var cards: [Card]
    @State var showCreateButton: ShowCreateButton
    var selectedCards: () -> Void
    var deselectedCards: () -> Void
    
    public init(showHeader: ShowHeader, cards: Binding<[Card]>, showCreateButton: ShowCreateButton, selectedCards: @escaping () -> Void, deselectedCards: @escaping () -> Void) {
        self.showHeader = showHeader
        self._cards = cards
        self.showCreateButton = showCreateButton
        self.selectedCards = selectedCards
        self.deselectedCards = deselectedCards
    }
    public init(showHeader: ShowHeader, cards: Binding<[Card]>, showCreateButton: ShowCreateButton) {
        self.showHeader = showHeader
        self._cards = cards
        self.showCreateButton = showCreateButton
        self.selectedCards = {}
        self.deselectedCards = {}
    }
    
    public var body: some View {
        
        ZStack {
            ScrollView(.vertical) {
                switch showHeader {
                case .yes(let headerTitle, let headerSubtitle, let headerSubtitleLocation):
                        ScrollViewTitleView(headerTitle: headerTitle, headerSubtitile: headerSubtitle, headerSubtitleLocation: headerSubtitleLocation, showCreateButton: showCreateButton)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .blur(radius: control.anyTicketTriggered ? 20 : 0)
                case .no:
                    EmptyView()
                }
                
                ForEach(self.cards) { card in
                    ExpandableCardView(selectedCard: selectedCards, deselectedCard: deselectedCards,card: card)
                            .environmentObject(self.control)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 30)
                }
                
            }
            
            VStack {
                SystemMaterialView(style: .regular)
                    .frame(height: self.control.anyTicketTriggered ? 0 : 40)
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .statusBar(hidden: self.control.anyTicketTriggered)
    }
    
}

struct ScrollViewTitleView: View {
    @State var headerTitle: String
    @State var headerSubtitile: String
    @State var headerSubtitleLocation: SubtitleLocation
    @State var showCreateButton: ShowCreateButton
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if headerSubtitleLocation == .above {
                Text(headerSubtitile)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.bottom, -5)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            HStack(alignment: .center) {
                Text(headerTitle)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                Spacer()
                
                switch showCreateButton {
                case .yes(let create):
                    ShowActionButton(systemSymbol: "plus") {
                        create()
                    }
                case .no:
                    EmptyView()
                }
                
            }
            if headerSubtitleLocation == .below {
                Text(headerSubtitile)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
        }
        .padding(.bottom, -5)
        
    }
    
}


//Ticket to -> Card
public struct Card : Identifiable, Equatable {
    public var id = UUID()
    
    public var title: String
    public var subtitle: String
    public var subtitleLocation: SubtitleLocation
    public var titleColor: Color
    public var briefSummary: String
    public var summaryColor: Color
    public var enableSummaryInCard: Bool
    public var description: String
    public var image: glyphImage
    public var featureCells: [FeatureCell]
    
    public init(title: String, subtitle: String, subtitleLocation: SubtitleLocation, titleColor: Color, briefSummary: String, summaryColor: Color, enableSummaryInCard: Bool, description: String, image: glyphImage) {
        self.title = title
        self.subtitle = subtitle
        self.subtitleLocation = subtitleLocation
        self.titleColor = titleColor
        self.briefSummary = briefSummary
        self.summaryColor = summaryColor
        self.enableSummaryInCard = enableSummaryInCard
        self.description = description
        self.image = image
        self.featureCells = []
    }
    public init(title: String, subtitle: String, subtitleLocation: SubtitleLocation, titleColor: Color, briefSummary: String, summaryColor: Color, enableSummaryInCard: Bool, description: String, image: glyphImage, featureCells: [FeatureCell]) {
        self.title = title
        self.subtitle = subtitle
        self.subtitleLocation = subtitleLocation
        self.titleColor = titleColor
        self.briefSummary = briefSummary
        self.summaryColor = summaryColor
        self.enableSummaryInCard = enableSummaryInCard
        self.description = description
        self.image = image
        self.featureCells = featureCells
    }
}

public enum SubtitleLocation: Hashable, Equatable {
    case above
    case below
    case none
}
public enum ShowCreateButton {
    case yes(create: () -> Void)
    case no
}
public enum ShowHeader {
    case yes(headerTitle: String, headerSubtitle: String, headerSubtitleLocation: SubtitleLocation)
    case no
}
