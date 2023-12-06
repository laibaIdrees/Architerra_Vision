# Use an official Flutter image as the base image
FROM cirrusci/flutter:latest

# Set the working directory in the container
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock files to the container
COPY pubspec.yaml pubspec.yaml
COPY pubspec.lock pubspec.lock

# Install dependencies
RUN flutter pub get

# Copy the entire project to the container
COPY . .

# Build the Flutter app
RUN flutter build apk --release

# Set the entry point for the container
CMD ["flutter", "run"]
