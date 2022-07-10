//
//  TabMenu.swift
//  boissibook
//
//  Created by Rémy Machavoine on 03/07/2022.
//

import SwiftUI

struct TabMenu: View {
    var body: some View {
        TabView {
            DownloadBooks()
                .tabItem {
                    Label("Lire", systemImage: "house")
                    Image(systemName: "house")
                }
            SearchBook()
                .tabItem {
                    Label("Ajouter", systemImage: "plus")
                }
            BooksHome()
                .tabItem {
                    Label("Bibliothèque", systemImage: "books.vertical.fill")
                }
        }
    }
}

struct TabMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabMenu()
    }
}
