# Carpool

Carpool is a small test application that shows cars avaiable for sharing. It consists of two screens. One is a list of cars and the other is a map with cars' locations.

## Technical details
### Overview
Basically the app utilizes SOLID principles though a couple of places could be enchanced. I used a MVP - VIP variation with coordinators. The basic flow is the following: the `AppCoordinator` creates a UITabBar subclass with the main data provider `AppDataWorker`. Then it asks the `CarListCoordinator` and the `MapCoordinator` for the TabBar's view controllers. Each view controller is configred inside its coordinator.

A screen consists of the following entities: View, Presenter and Interactor. Their responsibilities are similar to their siblings from VIPER.

### Special guest
`AppDataWorker`. This interactor is responsible for loading data from the fake network (the local storage) and for saving it to it's persistent storage. As the data on both screens is very similar and is received from one source the other interactors just tweak it a bit for their presenters. When the logic changes the interactors will become more clever.

### Project structure
The main module is `Carpool`. It has two main screens (user stories): `CarListView` and `MapView`. And a `TabBar` part which assembles them together and owns a data provider. Persisten storage is presented with the `CoreData` (and there's also an `InMemoryStorage` that I used for developing.

The main module uses CPCommon module where objects that are not related to any specific screen are. In case of further project developing I'd like to separate the existing `Carpool` module to different modules. For instance `Map`, `CarList`, `Networking`, `PersistentStorage`, `CPCommon`. I believe that separating into different modules with a strict public API makes the code more clean and flexible.

### Storyboards
Every storyboard consists of only one screen because in case of further project's growth it would be to overloaded to put everything in the tab bar storyboard. It's also more easy to connect and assemble everything with separate coordinators so I decided to keep it that way. Though this way screens relations are missing.

## Additional info
The project is localized. Its main language is english but russian and deutch are also presented.

## Installing
Download the repository and run the `pod install` command in the project's directory. Run the `Carpool.xcworkspace` file so the project includes `CPCommon` module and the pods. 

## Running the tests
The tests cover most of the interactions between different layers though there's always some place to test more. 

## Next steps
I'd like to enrich the project with the following features and enchancements:
First priority:
 - App Icon!
 - Add filter and search to the car list.
 - Make generic function to unify views registering.
 - Add declusterising.
 - Remove placemarks reloading when they have not changed.
 - Add filters to the map view.
 
"Would be nice to have"
 - Implement a server which sends the data which is local now.
 - Add some random car images. Without images it's a bit boring. And I already have the placholders!

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
For my small project I used a couple of icons from [The Noun Project](https://thenounproject.com). I mutated a couple of them and I hope you can't tell what are the exact ones :) Just kidding.

So, the icons and the authors:
Engine by Lloyd Humphreys, DK 
dashboard by hans draiman 
Car by jeff
Map by Rena, US 
List by unlimicon, ID 
Cars by ChangHoon Baek, CA 

And, well, what developer could forget about the great swift and stackoverflow community? Not me :)
