@core @javascript @core_form
Feature: Any day / month / year combination in date form elements works ok.
  In order to use date / datetime elements with Behat
  as a user
  Any day / month / year combination must work ok

  @javascript
  Scenario Outline: Verify that setting any date / datetime is possible
    Given the following "courses" exist:
      | fullname | shortname | format |
      | Course 1 | C1        | topics |
    And the following "activity" exist:
      | activity   | name          | intro                              | course | idnumber |
      | assign     | Assignment 01 | Assign activity to test some dates | C1     | assign01 |
    Given I am on the "C1" "Course" page logged in as "admin"
    And I follow "Assignment 01"
    And I navigate to "Edit settings" in current page administration
    And I expand all fieldsets
    And I set the field "Due date" to "<initial_date>"
    And I set the field "Due date" to "<final_date>"
    When I press "Save and display"
    Then the activity date in "Assignment 01" should contain "Due:"
    And the activity date in "Assignment 01" should contain "<date_result>"

    Examples:
      | initial_date | final_date        | date_result                            | case_explanation (times Australia/Perth)   |
      | ##today##    | ##tomorrow noon## | ##tomorrow noon##%d %B %Y, %I:%M %p##  | change of day, any day, back and forth     |
      | ##tomorrow## | ##today noon##    | ##today noon##%d %B %Y, %I:%M %p##     |                                            |
      | 1617256800   | 1617170400        | 31 March 2021, 2:00 PM                 | change of month, back and forth            |
      | 1617170400   | 1617256800        | 1 April 2021, 2:00 PM                  |                                            |
      | 1740808800   | 1709186400        | 29 February 2024, 2:00 PM              | change of month, leap year, back and forth |
      | 1709186400   | 1740808800        | 1 March 2025, 2:00 PM                  |                                            |
      | 1577858400   | 1577772000        | 31 December 2019, 2:00 PM              | change of year, back and forth             |
      | 1577772000   | 1577858400        | 1 January 2020, 2:00 PM                |                                            |
