//
//  HomeView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

let screen = UIScreen.main.bounds

public struct CardView: View {
    @EnvironmentObject var control: TicketCardView_Control
    @State var showHeader: Bool
    @State var headerTitle: String
    @State var headerSubtitile: String
    @State var headerSubtitleLocation: subtitleLocation
    @State var create: () -> Void
    //change cardData to real tickets
    @Binding var tickets: [Ticket]
    
    public init(showHeader: Bool, headerTitle: String, headerSubtitle: String, headerSubtitleLocation: subtitleLocation, tickets: Binding<[Ticket]>, create: @escaping () -> Void) {
        self.showHeader = showHeader
        self.headerTitle = headerTitle
        self.headerSubtitile = headerSubtitle
        self.headerSubtitleLocation = headerSubtitleLocation
        self._tickets = tickets
        self.create = create
    }
    
    public var body: some View {
        
        ZStack {
            ScrollView(.vertical) {
                if showHeader {
                    ScrollViewTitleView(create: {
                        create()
                    }, headerTitle: headerTitle, headerSubtitile: headerSubtitile, headerSubtitleLocation: headerSubtitleLocation)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .blur(radius: control.anyTicketTriggered ? 20 : 0)
                }
                
                ForEach(self.tickets) { ticket in
                    ExpandableCardView(ticket: ticket)
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
    
    }
    
}

struct ScrollViewTitleView: View {
    @State var create: () -> Void
    @State var headerTitle: String
    @State var headerSubtitile: String
    @State var headerSubtitleLocation: subtitleLocation
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if headerSubtitleLocation == .above {
                Text("MON, FEBUARY 31")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.bottom, -5)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            HStack(alignment: .center) {
                Text("Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                Spacer()
                
                ShowActionButton(systemSymbol: "plus") {
                    create()
                }
                
            }
            if headerSubtitleLocation == .below {
                Text("MON, FEBUARY 31")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
        }
        .padding(.bottom, -5)
        
    }
    
}


//MARK: Fake Data

//Ticket to -> Card
public struct Ticket : Identifiable {
    public var id = UUID()
    
    var title: String
    var subtitle: String
    var subtitleLocation: subtitleLocation
    var briefSummary: String
    var description: String
    var image: glyphImage
    
    public init(title: String, subtitle: String, subtitleLocation: subtitleLocation, briefSummary: String, description: String, image: glyphImage) {
        self.title = title
        self.subtitle = subtitle
        self.subtitleLocation = subtitleLocation
        self.briefSummary = briefSummary
        self.description = description
        self.image = image
    }
}

public enum subtitleLocation: Hashable, Equatable {
    case above
    case below
    case none
}
