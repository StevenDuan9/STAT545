# Assignment B-3 & B-4: Creat and improve a Shiny App
This repository is created to complete Assignment B3 & B4 as a part of STAT 545B course in UBC.
## Link:
- B3:[assignment B-3](https://stevenduan.shinyapps.io/assignmentB3/)
- B4:[assignment B-4](https://stevenduan.shinyapps.io/assignmentB4/)
## Description:
The __*Explore Vancouver Trees!*__ App allows users to interactively explore trees in vancouver. So far it has applied at least 10 different features to enhance user experience.
## Features:
### B-3:
1. Add CSS to make the app look nicer. The styles.css file sets the background color to light blue.
2. Add an image to the UI through `www` folder.
3. Show the number of results found whenever the filters change.
4. Use checkboxInput() to let users could decide whether they want to get data with NA values or not.
5. Add colourInput() to let the user decide the colors of the bars in the plot based on their preferences.
### B-4(New Features Highlighted):
1. Add CSS to make the app look nicer. 
2. Add an image to the UI through `www` folder.
3. Add dateRangeInput() for filtering date planted. Show the number of results found whenever the filters change.  
4. **Add sliderInput() for filtering height_range_id.**
5. **Add selectInput() for filtering boolean variable 'curb', 'assigned' and 'root_barrier'.**
6. Use checkboxInput() to let users could decide whether they want to get data with NA values or not.
7. **Add tabsetPanel() to create an interface with multiple tabs.**
8. **Allow the user to download table as a .csv file.**
9. **Use the DT package to turn a static table into an interactive table.**
10. Add colourInput() to let the user decide the colors of the bars in the plot based on their preferences.
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
