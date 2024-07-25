//
//  SearchView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 03.05.24.
//

import SwiftUI

struct Message: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
}

enum SearchScope: String, CaseIterable {
    case inbox, favorites
}

struct SearchView: View {
    @EnvironmentObject var currentMeeting: CurrentMeeting
    
    @ObservedObject private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.filteredAthletes, id: \.self) { athlete in
                    NavigationLink(destination: AthleteView(athleteId: athlete._id, athleteName: athlete.name)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(athlete.name)
                                Text(athlete.team?.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .overlay {
                if viewModel.fetching && viewModel.athletes == [] {
                    SpinnerView()
                }
            }
        }
        .task {
            viewModel.setup(currentMeeting)
            await viewModel.fetchAthletes()
        }
        .overlay {
            if (viewModel.filteredAthletes.isEmpty && !viewModel.fetching) {
                ContentUnavailableView.search
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}

#Preview {
    NavigationStack {
        SearchView()
            .environmentObject(CurrentMeeting.example())
    }
}
