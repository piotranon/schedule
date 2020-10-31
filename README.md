# schedule

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Name: Mobile App with schedule for UR
## Author: Piotr Długosz

## Technologies: 
- Flutter (dart) (for mobile app design)
- Django (python) (as RestAPI for schedule data)

## Description
App will be showing a weekly schedule for UR lecture.  
Data will be downloaded from django as RestApi request returning (json).
// image preview of UI

## Schedule analysis
Schedule is assigned to year of study, field of study and current year, so each one from that is unique.
    
Schedule contains list of days ["monday","tuesday",...]  
Each day contains list of lectures.

Lecture contains information about itself.

Lecture is assigned to week:  
- 1/3 (first and third week of the month)  
- 2/4 (second and fourth week of the month)  
- all (each week of the month)  

Each lecture is assigned to:  
- full year (all students on year)
- main group (all students devided to groups most often 2)
- laboratories group (students from main groups devided to groups)

        Example:
            There are 100 students on year. They are divided to 2 groups, each group is divided to 2 laboratories group.

        - group 1: students from 1 - 50
            - laboratories 1: students from 1 - 25
            - laboratories 2: students from 26 - 50
        - group 2: studnets from 51 - 100
            - laboratories 3: students from 51 - 75
            - laboratories 4: students from 76 - 100

Each student is assigned to one main group, laboratories group and speciality (if division to speciality exists).

## Data structure:
1. Models nested structure
    - Schedule 
        - fieldOfStudy (String)
        - yearOfStudy (String)
        - specialities (List String)
        - weekSchedule (Object weekSchedule)
            - daySchedule (Object daySchedule)
                - dayName (String)
                - lectures (List lectures)
                    - weeks (String)
                    - type (enum String)
                    - name (String)
                    - startTime (String)
                    - endTime (String)
                    - mainGroup (int)
                    - laboratoriesGroup (int)
                    - lecturer (lecturer)
                        - name (String)
                        - surname (String)
                        - email (String)
                        - academicTitle (String)
1. Individual models with shost description
    
    - Schedule  
         Contains information about field of study, year of study, specialities,
         and weekly schedule.
        - fieldOfStudy (String)
        - yearOfStudy (String)
        - specialities (List String)
        - weekSchedule (Object weekSchedule)

    - weekSchedule  
        Contains list of day schedules as a week schedule.
        - daySchedule (List daySchedule)

    - daySchedule  
        Contains day name, and List of lectures for specified day.
        - dayName (String)
        - lectures (List lectures)

    - lectures  
        Contains information about a lecture, weeks specifies which week is lecture in {"1/3","2/4","all"}, name is name of the lecture, startTime is a time when lecture starts, endTime is a time when lecture ends, mainGroup is a group for which is lecture, laboratoriesGroup is a group for which is a lecture, specialization is a group for wich is a lecture, lecturer informations about a lecturer.
        - weeks (String)
        - name (String)
        - type (Enum String {"lecture","exercise","laboratories"})
        - startTime (String)
        - endTime (String)
        - mainGroup (int) (nullable)
        - laboratoriesGroup (int) (nullable)
        - specialization (String) (nullable)
        - lecturer (lecturer)
    
    - lecturer  
        Contains information about a lecturer.
        - name (String)
        - surname (String)
        - email (String)
        - academicTitle (String)