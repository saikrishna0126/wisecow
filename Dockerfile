# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat

# Set the PATH environment variable to include /usr/games
ENV PATH="/usr/games:${PATH}"

# Copy the application script
COPY wisecow.sh /usr/local/bin/wisecow.sh

# Make the script executable
RUN chmod +x /usr/local/bin/wisecow.sh

# Expose the application port
EXPOSE 4499

# Define the command to run the application
CMD ["/usr/local/bin/wisecow.sh"]
