# Anime-EDA-and-SQl-Queries

## Made with Aitor Vergara Martín
- https://github.com/aitor-vergaramartin/

![alt text](https://github.com/Esalsac/Anime-EDA-and-SQl-Queries/blob/main/Images/Doraemon.png?raw=true)

## Description of Repo

A first attempt at EDA using the top 1000 anime dataset below from kaggle.com acompanied by presentation slides and demo SQl queires on the original dataset.

## EDA Questions
 
- ### How does series runtime vary over time for TV and movies?
- ### Is there a Relationship between Studio,Genre and Rating?




## Dataset Overview

A dataset containing the top 1000 anime from myanimelist.net for the year 2024.

### Shape

- 1000 rows by 22 columns

### Data 

Contains data concering:

- Ranking (1-1000)
- User ratings
- Title in Japanese
- Title in English
- Genres
- Studio
- Air dates
- Type of media (Movie,TV,OVA,etc...)
- Single instance duration
- Number of instances in title

And other Data that were not relevant to our EDA questions.

### Dataset dimensions

- 1000 rows by 22 columns

### Link to Dataset

https://www.kaggle.com/datasets/bhavyadhingra00020/top-anime-dataset-2024/data


## Steps Taken

Fitered out data that was irrelevant to bothe EDA questions. And then began to build seperate dataframes for each individual question. As the diagrams below illustrate:

![alt text](https://github.com/Esalsac/Anime-EDA-and-SQl-Queries/blob/main/Images/Cleaning_process_overall.webp?raw=true)

![alt text](https://github.com/Esalsac/Anime-EDA-and-SQl-Queries/blob/main/Images/Cleaning_process_Q1.webp?raw=true)

![alt text](https://github.com/Esalsac/Anime-EDA-and-SQl-Queries/blob/main/Images/Cleaning_process_Q2.webp?raw=true)

After this we plotted distributions and heat maps to draw our preliminary conclusions.

## Insights

### Series Runtime Overtime
#### TV
We noticed a shift in series length. Starting from the 1990s the data begins to show preference for 24 episode series that was reflected in total show runtime. this preference slowing began to shift to 12 episodes as a default format.

![alt text](https://github.com/Esalsac/Anime-EDA-and-SQl-Queries/blob/main/Images/decades_tv.png?raw=true)

#### Movies

No substantial conclusions were drawn as sampling volume became an issue but we did manage to observe a stable mean and a high bias in the data to the 2010s.

![alt text](https://github.com/Esalsac/Anime-EDA-and-SQl-Queries/blob/main/Images/decades_movies.png?raw=true)

### The Relationship Between Genre Studio and Rating Score

We found that particular studios only produced shows of particular genres, and showed more success with some of their genre roster than with the rest. Sample plots of mean rating by genre, mean rating by genre per studio and meanrating by studio per genre are provided alongwith a heatmap showing the highest mean rating combination of studio and genre are provided.

![alt text](https://github.com/Esalsac/Anime-EDA-and-SQl-Queries/blob/main/Images/genre_studio_rating_heatmap.png?raw=true)