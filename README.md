Event Planner
===

# Eventer

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Hosting an event or party requires a lot of effort, thinking and coordination and when a group of people organize an event there is confusion about who’s in charge of what and when. Also during massive events like BGR, students come across various events around campus and since there is no central  platform which organizes and lists all the event dates and details, students tend to miss events due to forgetfulness or time conflict. Happening Place is an app which allows you to effectively host events by allowing multiple members to simultaneously plan for a single event without any hassle. It also allows users to find relevant events around them. Though several event-finding apps such as EventBrite, which lists nearby events, exist none of them offer the feature of multiple users planning and contributing to a single event which enables workload distribution.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Organizing and Productivity
- **Mobile:** Iphone X
- **Market:** Mostly college campus but can be extended
- **Habit:** N/A
- **Scope:** N/A

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User has ability to signups
* User should be able to sign-in.
* A user should have ability to create an event
* A user should have ability to view all events
* A user should have ability to view events by location
* A user can RSVP to an event
* A user, who is also the host of the event, can edit the event
* A user can view all events you have RSVPd to
* A user should be notified before the event

### 2. Screen Archetypes

* Login
   * User can login
* Signup
   * User can register
* Event creation and edit
   * User can create event
   * User can edit event
* View events screen
   * User can view all events
   * User can view all events they have RSVPd too
   * User can view events by location

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Login
* Signup
* Event creation and edit
* View events sceen

**Flow Navigation** (Screen to Screen)
* Login
   * View events screen
   * Signup
* Signup
   * View events screen
* Event creation and edit
   * View events screen
* View events screen
   * event creation and edir


## Wireframes
Created Digital Wireframe

### [BONUS] Digital Wireframes & Mockups
<img width="525" alt="part1" src="https://user-images.githubusercontent.com/32022063/76722490-c676c980-6711-11ea-9fc7-4e899c945cb5.png">
<img width="520" alt="part2" src="https://user-images.githubusercontent.com/32022063/76722496-cbd41400-6711-11ea-8a45-781b2cf4d48e.png">


### [BONUS] Interactive Prototype
<img src="http://g.recordit.co/Ckza9qRaAG.gif" width=300>

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- Get user details (authorization)
- save user details (signup)
- View all events user has RSVPd for
- View all events available (and optionally by location)
