# Use an official Flutter image as the base image
FROM cirrusci/flutter

# Set the working directory in the container
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock files to the container
COPY pubspec.yaml pubspec.yaml
COPY pubspec.lock pubspec.lock

# Install dependencies
RUN flutter pub get

# Add debug prints to troubleshoot
RUN echo "Listing files in /app:"
RUN ls -la
RUN echo "Listing files in /app/lib:"
RUN ls -la lib

# Copy the entire project to the container
COPY . .

# Add debug prints after copying the project
RUN echo "Listing files after copying the project:"
RUN ls -la

# Build the Flutter app
RUN flutter build apk --release

# Set the entry point for the container
CMD ["flutter", "run"]
