# BreakingBad

[BreakingBad API doc](https://breakingbadapi.com/)

Implemented MVVM-C (Coordinator) architecture pattern for the project. Which is satisfying SOLID principples altogether.
Protocol oriented development has been followed.

Project is containing multiple Coordinators to handle specific navigation flow ,
- DashboardCoordinator (handiling flow to Dashboard)
- CharactersListCoordinator (handling flow to Characters list -> DetaiVC)
- EpisodesListCoordinator (handling flow to Episodes list -> DetaiVC)
- QuotesListCoordinator  (handling flow to Quotes list)

All coordinators holding an **Interactor** for specific required protocols to call needed Web-API
- CharactersProvider
- EpisodesProvider
- QuotesProvider

Implemented CI/CD Pipeline for both branches **(main & master)**. (note: archieve script has not been written due to not having enrolled myself into developer program)
in _**.gitlab-ci.yml**_ file archive script is not written but can have a look on separate file- _**archive.sh**_

Project contains [Cocoapods](https://cocoapods.org/) dependency manager to handle dependencies like,
- [Kingfisher](https://github.com/onevcat/Kingfisher) (to downloading an image)
- [SwiftLint](https://github.com/realm/SwiftLint) (to improve code quality)

For TDD approach written test cases for ViewModels, so code coverage will not be that good. :(

Most of the screen in app, supports **Dark** and **Light** theme

//TODO: list 
- More tests cases to improve code coverage
- Removing storyboards
