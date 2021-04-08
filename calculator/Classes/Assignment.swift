//
//  Assignment.swift
//  calculator
//
//  Created by Yannick Vanderstraeten on 2021-03-19.
//

import Foundation

//
//  Requirement:
//  Create a simple bankomat app
//
//  Two ways a user can interact:
//  1.  Put in money
//  2.  Extract money, giving the user the least amount of banknotes necessary with banknotes that are available
//  2b. Additional after 1 and 2 are finished: Allow the user to choose "Prefer small banknotes"
//
//  When user extracts money, display in console (print) which notes were given to him (which value and how many)
//  eg. Based on available banknotes, if user extracts 100, possible outputs:
//  "50: 2"
//  "50: 1, 20: 2, 10: 1"
//
//  Don't worry about the formatting, print it out in any form you want
//

// Dont forget the additional method to separate printing out the result of the withdrew

// Follow up
// refillCash defaults all types of Banknotes
// refillCash only fills up 4 out 7 types
//
// Goal of this task
// Actively using optional values to determine if notes are available
// At this time if there aren't any notes available, it means quantity == 0
// Moving on
// if no banknote is not available, it means it's not in the array --> effectively nil
// if a value of a note reaches zero -> remove it from the array
