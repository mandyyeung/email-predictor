# Email Predictor

A Ruby on Rails tool to help predict company email addresses based on known formats.

## Options for Data

### Option 1. Generated seed file

The following dataset has been used to generate the db/seeds.rb file:

```# db/advisors.json
{
   "John Ferguson":"john.ferguson@alphasights.com",
   "Damon Aw":"damon.aw@alphasights.com",
   "Linda Li":"linda.li@alphasights.com",
   "Larry Page":"larry.p@google.com",
   "Sergey Brin":"s.brin@google.com",
   "Steve Jobs":"s.j@apple.com"
}
```
### Option 2. Customized seed file

To use a custom list of contacts, replace the data in db/advisors.json with your own JSON data in the same format. Generate the seed file:

`ruby db/generate_seed.rb`

## Running the Application

Seed your database with this data:

`rake db:seed`

Start your Rails server (using Puma):

`rails s` and visit *http://localhost:3000*

## Screenshots

![Enter a name](http://imgur.com/OCsyHHM.png)
![Enter a company domain](http://imgur.com/LNepLia.png)
![Review information](http://imgur.com/5hPw7h9.png)
![Receive predicted email addresses](http://imgur.com/6pxbHtQ.png)

## Future Improvements

* Account for other formats of names (middle names, use of dashes, first names of more than one name)

* Use the API from [verify-email.org](http://verify-email.org/) to validate predicted email addressse
