# Favorite Place App

## Introduction

The Favorite Place app allows users to capture and save their favorite places, complete with photos and location details. Leveraging the power of Flutter, the app provides a seamless experience for users to remember and revisit their cherished spots. With an integrated `sqflite` database, users can store their data directly on the client side, ensuring quick access and offline capabilities.

## Screenshots

![Add Favorite Place Screen](./screenshots/Add%20Favorite%20Place%20Screen.png)
*Add New Place Screen*

![all Favroite Places](./screenshots/all%20Favroite%20Places.png)
*List of All Favorite Places*

![Preview of photo Location](./screenshots/Preview%20of%20photo%20Location.png)
*Preview of Selected Photo and Location*

![After Add Photo Name Location](./screenshots/After%20Add%20Photo%20Name%20Location.png)
*View After Adding a Photo, Name, and Location*

## Features

- **Add New Place**: Users can seamlessly add a new place with a photo and location details.
- **View Place Details**: Click on a place to view its detailed information.
- **List of Favorite Places**: A dedicated screen to view all saved places.
- **Map View**: Visualize the location of your favorite places on a map.

## Project Structure

- **main.dart**: The main entry point of the app.
- **api**:
  - `favorite_place_api.dart`: Handles database interactions for the Favorite Place feature.
- **providers**:
  - `favorite_places_provider.dart`: Manages the state and data related to favorite places.
- **models**:
  - `favorite_place.dart`: Data model representing a favorite place.
- **screens**:
  - `detail_place_screen.dart`: Screen for viewing details of a selected favorite place.
  - `add_place_screen.dart`: Screen to add a new favorite place.
  - `home_screen.dart`: Main screen that lists all the favorite places.
  - `map_screen.dart`: Screen to visualize the location of favorite places on a map.
- **widgets**:
  - `favorite_places_list.dart`: Reusable widget to display a list of favorite places.
  - `image_input.dart`: Widget for image input.
  - `favorite_place_tile.dart`: Widget for displaying a single item in the favorite places list.
  - `location_input.dart`: Widget for location input.

## Installation & Setup

1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to fetch the dependencies.
4. Run `flutter run` to start the app.

## Dependencies

- Flutter SDK
- `sqflite` for client-side database storage.

## Future Enhancements

- Cloud sync for backing up favorite places.
- Social sharing options.
- User profiles and authentication.

## Contribution

Feel free to fork the project, open a PR, or submit issues for any suggestions, bugs, or improvements.

## License

This project is open source and available under the [MIT License](LICENSE).
