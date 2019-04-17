## Purdue Calorie Calculator
App for Purdue Students to easily track and store caloric and nutritional info from Purdue dining courts.  

Category: health & fitness 
Evaluation: 
Mobile: This mobile app is way more convenient than using a website.  
Story: For people trying to monitor caloric/nutritional intake, this app would be very convenient and helpful.  
Market: Population of Purdue students living on campus.  
Habit: This app can easily create a habit because if the user uses the app every time they eat at a dining court, they will use it at least 2 times a day on average.  
Scope: The app does not use techniques that are extremely challenging, and even a stripped-down version of the app would still involve various fundamentals and aspects of iOS programming.  

Product Spec 
## 1. User Stories (Required and Optional) 

**Required Must-have Stories** 
- [X] User can see calorie/nutritional info for all items at all dining courts. 
- [X] User can "add to an order," which will add caloric/nutritional info of chosen foods and calculate total values. 
- [ ] User can view past meals and past data. (Decided to cut)  

**Optional Nice-to-have Stories** 
- [ ] Can tell user closest dining court 
- [ ] Data visualization for graphs/progress meters
- [X] Calorie/nutritional goals 
- [ ] Alerts for when dining courts close if you haven't eaten a meal 
- [ ] Tell which dining court has healthiest food for the day (least fat/sugar)
- [ ] Calculate nutritional needs for a user's height/weight 

## 2. Screen Archetypes 
* Login / Register 
* Stream 
* Profile 
* Creation 
* Settings 

## 3. Navigation 

**Tab Navigation** 

(Tab to Screen)
* Today 
* Menu 
* Profile

**Flow Navigation** (Screen to Screen)

 * Login / Register
   * => Stream
 * Stream
   * => Creation
 * Creation
   * => Stream
 * Profile
   * => None
 * Settings
   * => None
   
## Wireframe

![Wireframe](https://github.com/purduenutritioncalculator/PurdueNutritionCalc/blob/master/iOS%20Wireframe.jpg)

## Models

Food Item

|Property|Type|Description|
|---|---|---|
|Id|String|API's unique identifier for a food item|
|Name|String|Name of item|
|Calories|Integer|Number of calories in item|
|Serving size|String|Description of one serving for item|
|Fat|Integer|Grams of fat in item|
|Protein|Integer|Grams of protein in item|
|Carbs|Integer|Grams of carbs in item|
|Sugar|Integer|Grams of sugar in item|
|Allergens|String|List of allergens item contains|

Dining Court

|Property|Type|Description|
|---|---|---|
|Name|String|Name of dining court|
|Picture|url|Link to dining court's logo/picture|
|Menu|Array of food items|Food items being served in dining court|
|Times|String|Times for breakfast, lunch, and dinner in that court for current day|

Meal

|Property|Type|Description|
|---|---|---|
|Items|Array of food item objects|Contains all food items eaten for that meal|
|Date|String/date object|Date/time that meal was eaten|

## Networking

Meal Select View
 * GET request for chosen dining court's information

Menu Detailed Item View
 * GET request for chosen item's information
 
## Progress Gifs for Sprint 1

![](Sprint1Gif.gif)

## Progress Gifs for Sprint 2

![](Sprint2Gif.gif)

## Progress Gifs for Sprint 3

![](Sprint3Gif.gif)
