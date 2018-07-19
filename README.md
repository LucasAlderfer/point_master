# README

**This Repo was created to fulfill the requirements for a project as a student at the Turing School of Software and Design**

### Project Option 3: PointBox

Create an app where an admin (let's say for example, Richard) can assign points to users and users can redeem those points for rewards. Host your app live on Heroku.

#### Points

- [x] Points can be created ("assigned to a user") and destroyed only by the admin.
- [x] Points can be destroyed only by the admin.
- [x] Users can see their total number of points on their dashboard

#### Rewards

- [x] Rewards can be created only by the admin.
- [x] Rewards can be edited only by the admin.
- [x] Rewards can be updated only by the admin.
- [x] Rewards can be destroyed only by the admin.
- [x] The list of possible rewards can be seen by regular users.

#### Redeeming Points

- [x] Users can redeem their points for a reward.
- [x] When users redeem their points, the points are NOT destroyed; instead, they are marked as "redeemed".
- [x] when a user redeems points for a reward, the user can see that reward on their dashboard.

#### Authentication and Authorization

- [x] Users need to log in to see their points and rewards.
- [x(my user dashboard intentionally includes this information, but a user cannot visit another user's page)] Users can only see their own points and rewards -- they should not be able to visit another user's page.
- [x] Users cannot add points to their account.
- [x] Users cannot create new rewards to add to the list.
- [x] A user cannot redeem another user's points.
- [x(Anyone can create a new user through the sign up page)] Admin can create a user.

#### User Experience

- [x] The application has been styled.
- [x] The application uses a balanced, considered color scheme.
- [x] The application implements a font (that is not the default font).
- [x] The application utilizes a nav bar.
- [x] The style shows evidence of intentional layout.
- [x] Space and text is balanced. White space is used to visually separate content.
- [x] The application is easily usable. The user can intuitively navigate between different portions of the application without manually entering the URL into the nav-bar or using the back button on their browser.

#### Database

- [x] Properly implements a one-to-many relationship
- [x] Properly implements a many-to-many relationship
- [x] Utilizes primary and foreign keys appropriately

#### Code Quality

- [x] Logic lives in the appropriate files
- [x] Methods are refactored and follow SRP
- [x] Naming follows convention
  (This is my evaluation, to the best of my knowledge.)

#### Testing

- [x] Project has a running test suite
- [x] Test suite includes robust feature tests
- [x] Test suite includes tests for validations
- [x] Test suite includes tests for methods that they have created on the models

#### Optional Extensions

- Implement Twitter, Github, or Facebook OAuth login
- Use HAML for your views
- TDD using RSpec instead of Test::Unit
