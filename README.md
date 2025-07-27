# README

Intial Startup:
bundle && rails db:create && rails db:migrate

Simulate data:
on heroku, we have simulated some searches to help showcase and highlight the analytics tools. a seed is available
if you wanna achieve this effect in a local setting. just run rails db:seed after the initial setup.

Highlighted features:
1) User dashboard: you will have a dashboard displaying all the searches attached to your Ip address and visualize the data behind them.

2) Global dashboard: you will have a dashboard displaying all the searches made by everyone and visualize the data behind them.

3) Simulate searches: in the user dashboard you can have randome searches simulated with a click of a button, they will be timestamped on ramdom dates to help with visualization.

4) Clear searches: you can clear all the searches made by you from the user dashboard.

Dependancies:
1. Ruby version: 3.4.4.
2. rails version: 8.0.2.
3. databse: postgresql.
4. front-end library: Bootstrap V5
5. highlightes gems: Faker, scss-rails, bootstrap, chartkick, groupdate.

you can see the deployed version here:
https://realtimesearchbox-43a72f8716c1.herokuapp.com/home
