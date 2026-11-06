# Use an official Ubuntu base image
FROM ubuntu:latest

# Install g++, make, and the hiredis library
RUN apt-get update && apt-get install -y \
    g++ \
    make \
    libhiredis-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Compile the application (linking the hiredis library and including the header folder)
RUN g++ -std=c++17 -I include src/*.cpp -o vault -lhiredis

# Since this is a CLI tool, keep the container alive with bash
CMD ["/bin/bash"]