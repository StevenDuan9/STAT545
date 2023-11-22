# Assignment B-3: Creating a Shiny App
This repository is created to complete Assignment B3 as a part of STAT 545B course in UBC.
## Link:
[Explore Vancouver Trees!](https://stevenduan.shinyapps.io/assignmentB3/)
## Description:
The __*Explore Vancouver Trees!*__ App allows users to interactively explore trees in vancouver. It plots the number of trees with different diameter within your selected time period. So far it has applied at least five different features to enhance user experience:
## Features:
1. Add CSS to make the app look nicer. The styles.css file sets the background color to light blue.
2. Add an image to the UI through `www` folder.
3. Show the number of results found whenever the filters change.
4. Use checkboxInput() to let users could decide whether they want to get data with NA values or not.
5. Add colourInput() to let the user decide the colors of the bars in the plot based on their preferences
## Getting Started:
To modify and run this Shiny app locally, follow these steps:
1. Clone this repository to your local Rstudio using `git clone`.
2. Make sure you have required libraries installed.
3. Open the R script (app.R) in RStudio.
4. Run the app by clicking the "Run App" button.
## Contributing:
We welcome contributions! If you would like to contribute to this project, please follow these guidelines:
- Open an issue to discuss proposed changes.
- Fork the repository and create a new branch.
- Commit your changes and submit a pull request.
## Dataset Source:
The dataset used in this assignment is *vancouver_trees*. You could visit [this website](https://opendata.vancouver.ca/explore/dataset/street-trees/information/) to get more information about this dataset. Simply use the code below to access the dataset:
```R
install.packages("devtools")
devtools::install_github("UBC-MDS/datateachr")
library(datateachr)
library(tidyverse)
data(vancouver_trees)
```
