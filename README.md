Group Project - README Template
===

# IntelliVote

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app helps eligible NYS voters stay informed about voting on the future elections

### App Evaluation

- **Category:** Reference
- **Mobile:** Upload home address and receive list of candidates, list of future candidates, and voting location.
- **Story:** With the goal of increasing awareness of the political climate, we intend to keep US citizens up to date with the activities of their local politicians. Thus, creating a culture of political involvement and an overall betterment of the community. We decided on making the app because while the app store contains similar voting apps, they only exist for states such as California and Texas and not for New York. Instead of having to search the entire web, the app is a convenient space where the user can find all the information they need to make an educated vote.

- **Market:** We are targeting New York State residents, especially the youth/Millenials, who desire to stay politically involved. 
- **Habit:** The user may use the app frequently one or two months before the election date.
- **Scope:** This app will only be useful for New York state residents.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Login
* Logout
* See the candidates list
* Display voting location

**Optional Nice-to-have Stories**

* Apple Maps integration to go to voting area
* Link to candidate website
* Voting Mechanism(perhaps using blockchain tech)
* Notify the user of any activity of the politicians.

### 2. Screen Archetypes

* Login
  * Login - User can login with Address
* See the current candidates list
* Stream - User can scroll through the list of candidates
* Display voting location
  * Map View - User can view voting location on the map

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Map
* Candidates/Officials

**Flow Navigation** (Screen to Screen)

* Login
  * Candidate List
* See the current candidates list
  * Voting Location
* Display voting location
  * Candidate List


## Wireframes

<img src="wireframedraw.png" width=600><br>


### [BONUS] Digital Wireframes & Mockups
<img src="/ACgwFrLwDc.gif" width=250><br>


## Schema 
### Models

**Post**

<img src="/datamodel.png" width=800><br>


### Networking
- Login Screen
    - (Read/GET) Check validation of login via Heroku
- Register Screen
    - (Create/PUT) Creat account to allow login via Heroku
- Positions Screen
    - (Read/GET) Get list of available positions via Google Civics
- Candidates Screen
    - (Read/GET) Get list of candidates in desired position via Google Civics
- Vote Location Screen
    - (Read/GET) Get address of nearest voting location via Google Civics, return
        snippet of map in webview
        
        
## Unit 10 Submission
<img src="http://g.recordit.co/AOxggjAR6T.gif" width=800><br>

## Unit 11 Submission

<img src="http://g.recordit.co/vyhLau3fWT.gif" width=250><br>

## Unit 12 Submission

### User verification
<img src="http://g.recordit.co/k00m28HnQs.gif" width=250>

### Map feature
<img src="http://g.recordit.co/dbndQWN6Xq.gif" width=250><br>




