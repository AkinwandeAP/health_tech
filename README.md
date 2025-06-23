# HEALTH TECH
This repository contains the final project developed under an initiative organized by GIZ (Deutsche Gesellschaft für Internationale Zusammenarbeit) and Yaba LCDA. The project explores the use of simulated health datasets for analysis, modeling, and basic web application development. Our aim was to simulate, analyze, build a predictive model, and develop a basic application interface to test the model's performance.

## TOPIC 
Misdiagnosis in emergency cases due to underutilization of electronic medical records

## PROBLEM STATEMENT
#### STEP 1: Using the “5 Whys”
1. Why is the patient misdiagnosed during emergency? Because there is no medical history.
2. Why is there no medical history? Because there is no medical record.
3. Where is there no medical record? Because there is no system for electronic medical records.
4. Why is there no EMR for patients? Because the health sector has not effectively implemented ICT.
5. Why has the health sector not implemented ICT? Because EMRS have not been mandatory in health sector and staff training in the effective use of EMRS.
Root Cause: Lack of accessible EMRS to health workers.

STEP 2: Building a fishbone diagram (Six categories)
1. People
- Inadequate training of health information personnel.
- Shortage of Health workers
- Unavailability of some important health workers like Paramedics and First-aiders

2. Process (Methods)
- No prompt response to emergency scenes
- No systemic approach to emergency care/case

3. Technology (Machines)
- No Electronic Medical Records
- No emergency management system

4. Environment
- Insufficient emergency centers.
- No short admission stay for emergency cases

5. Measurement
- Response time
- Linking patient records for different hospital sources.

6. Materials
- Unavailability of some facilities in the centers
- Insufficient consumables and first aid equipment in the clinic


## Folders
The repository is structured into several folders, each serving a specific purpose:
The "data" folder contains both the raw health data (CSV format) used for SQL and Power BI analysis, and the simulated data generated using Python.

The "model" folder includes code used for data preprocessing and training a machine learning model.

The "flask_app" folder contains the files for a basic web application, built using Flask, designed to test the model’s predictions. Please note, this application was not deployed.

The "sql query" folder houses SQL scripts used for querying and analyzing the raw health data.

These components demonstrate a full pipeline from data simulation and analysis to model development and application prototyping.

## Tools Used
- Python – Used for data simulation, cleaning, and model development
- Flask – Used to build a simple backend web application
- SQL – For data querying and exploration
- Power BI – To create visual dashboards for insights
- Pandas, NumPy – For data manipulation
- Scikit-learn – For training and testing the machine learning model
- Jupyter Notebook – For prototyping and exploratory data analysis

## Features
- Generation of simulated health data using Python
- Data cleaning and manipulation using Excel and SQL
- Visual data exploration and insights using Power BI
- Predictive modeling with scikit-learn
- A prototype Flask web app for testing model predictions (not deployed)

## Disclaimer
This project was developed for educational purposes only. The datasets are simulated and the web application was created as a prototype and not deployed for public use. This is not intended for clinical or diagnostic decision-making.