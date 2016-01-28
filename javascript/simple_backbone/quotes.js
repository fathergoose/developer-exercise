/* eslint-disable */
/*

**Backbone JS notes**
  Uses models and views to provide organization
    Models:
      Emit events to views, hold business logic, hold data
    Views:
      Listen for model changes, interact with user, sends captured data to model
      Reflect what the model data 'looks' like
  Collections
    used to get multiple model objects
    ex. some_collection.fetch() ~= GET /quotes/
    vs. some_model.fetch() ~= GET /quotes/#id
  Routing:
    Useful for linking urls to spcific 'locations' within an app
    Can also help with browser back arrow in an all JS application
    Shouldn't need it for the quote list
  Events:
    May be added to any model
    No need to declare before use
  Extend:
    Used to create own model classes w/ backbone funcationality

*/
var test = Backbone.Model.extend({ // eslint-disable-line
  initialize: function() {
    alert('hey hey hey'); // eslint-disable-line
  }
});

var Quotes = Backbone.Collection.extend({
  model: 'quoteModel',
  url: 'https://gist.githubusercontent.com/anonymous/\
  8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/\
  quotes.json',
//  parse: function(data) {
//  return data.books; // parse can help clean up a messy API
//  }
});

// Fetching should happen in the view rendering function
// Something like var quoteView = Backbone.View.extend(el:'#somediv', {},{},)
// Fetching returns a promise and can be used with promise.done(function(){do once promise is fufilled})
// .done() is a jQuery method for deferred objects allong with deferred.always() and .fail()
// var quotes = new Quotes();
// quotes.fetch({
// });

// Views

//Templates with views
//  Apparently many options, but _.template() seems to be std.
//    These work by setting var somevar = _.template();
//  Views need el property in initialization (JS) and somewhere on the page (HTML) so they can bind events from the DOM
//    Someone just refered to el as a "landing place" for template content

var QuoteView = Backbone.View.extend({
  initialize: function() {
    alert("view initialized");
  }
})
