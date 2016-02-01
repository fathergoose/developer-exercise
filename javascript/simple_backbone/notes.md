# Summary/Reflection #
That was a great learning experience. Before completing this exercise
my JavaScript experience was very limited (still is). However,
after a weekend of letting this one sink in, I was able to sit down
and solve the previous issue relatively quickly and directly. I
look forward to applying this newfound JS-foo to an overhaul of my
on-line music player. I recently heard someone say, "The worst programmer
I know is myself last year." Agreed, except right now it feels that way
about last week. :)
**Backbone JS notes**
  - Uses models and views to provide organization
    - Models:
      - Emit events to views, hold business logic, hold data
    - Views:
      - Listen for model changes, interact with user, sends captured data to model
      - Reflect what the model data 'looks' like
  - Collections
    - used to get multiple model objects
    - ex. `some_collection.fetch() ~= GET /quotes/` vs. `some_model.fetch() ~= GET /quotes/#id`
    - `parse = function(data) {};` can be used to clean up messy APIs
  - Routing:
    - Useful for linking urls to specific 'locations' within an app
    - Can also help with browser back arrow in an all JS application
    - Shouldn't need it for the quote list
  - Events:
    - May be added to any model
    - No need to declare before use
  - Extend:
    - Used to create own model classes w/ backbone functionality
    - Fetching should happen in the view rendering function
    - Something like `var quoteView = Backbone.View.extend(el:'#somediv', {},{},)`
    - Fetching returns a promise and can be used with `promise.done(function(){do once promise is fufilled})`
    - `.done()` is a jQuery method for deferred objects along with `deferred.always()` and `.fail()`

  - Views

    - Templates with views
      - Apparently many options, but `_.template()` seems to be std.
      - These work by setting `var somevar = _.template();`        - Views need el property in initialization (JS) and somewhere on the page (HTML) so they can bind events from the DOM
      - Someone just refered to el as a "landing place" for template content
      - I want to have a `render()` called on initialization of the view objects
       - have `render()` load the template into the el property

  - Pagination
    - **rest:** pass rest and index and it returns the rest of the elements in an array aka tail or drop
    - **first:** pass first some number (n) and get the first n elements of the array back
    - **map:** will produce a new array of values by mapping **each** value in a list through function
