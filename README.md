# Stride Database Server

This repository contains the Docker configuration and the finished Ground Truth database dump for the Stride routing engine.

### How to Start the Database
1. Make sure Docker Desktop is running.
2. Open your terminal in this folder and run:
   `docker-compose up -d`

### How to Load the Map Data
Run this command to inject the completed Midtown database into your local Docker container:
`cat stride_ground_truth.sql | docker exec -i stride-db-db-1 psql -U admin`

*Note: You only need to run the data injection command once.*
