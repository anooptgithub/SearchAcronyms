# Acronym Finder

This application helps you search for Ancronyms to know its Full Form versions.

## Architecture & Code
- The App uses VIPER architecture and language used is Swift 5.
    - View - UIView and UIViewController and SwiftUI views belong here.
    - Interactor - Responsible for handling data and data related buisiness logic
    - Presenter - Takes care of presentation of Views and also coordination with interactor.
    - Entity - Represented by Service Models from API layer.
    - Router - Acts as a wireframe creator
- All modules are using dependency injection for ensuring testability.
- The main UIViewControllers were built using UIKit
- Empty state and loading state views are created using SwiftUI for demostration purpose.
- Unit tests are also added, however needs to improve the coverage.

## Features
1. User can Search for Acronyms or Initialisms in the search bar.
2. When a valid result is available, it is shown as a list using UITabeView.
3. The app has the following states:
   -  Begin search state
   -  Search In progress state
   -  No Results state representing either no full forms available or when there is an error
   -  Show results state which shows the list of meanings in the table view.

## Screenshots
![](https://github.com/anooptgithub/SearchAcronyms/blob/main/AcronymFinder/AcronymFinder/Resources/Screenshots/BeginsSearch.png)
![](https://github.com/anooptgithub/SearchAcronyms/blob/main/AcronymFinder/AcronymFinder/Resources/Screenshots/ShowResults.png)
![](https://github.com/anooptgithub/SearchAcronyms/blob/main/AcronymFinder/AcronymFinder/Resources/Screenshots/SearchInProgress.png)
![](https://github.com/anooptgithub/SearchAcronyms/blob/main/AcronymFinder/AcronymFinder/Resources/Screenshots/NoResults.png)
