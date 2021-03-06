/* eslint-disable */
var currentPage;

var Quote = Backbone.Model.extend({ // eslint-disable-line
  initialize: function() {
  },
  defaults: {
    context: '',
    quote: '',
    source: '',
    theme: '',
  }
});

var Quotes = Backbone.Collection.extend({
  model: Quote,
  url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json',
  paginate: function(itemsPerPage, currentPage) { // now heaviliy edited http://stackoverflow.com/questions/10470481/pagination-in-backbone-js
    var collection = this; // point collection to this {instance of Quotes}
    var restOfCollection = _(collection.rest(itemsPerPage*(currentPage - 1))); // drop everything before page n
    var currentPageCollection = _(restOfCollection.first(itemsPerPage)); // take the first itemsPerPage number of items from restOfCollection
    return currentPageCollection.map( function(model) { // turn each model into JSON... isn't this JSON already??
      return model.toJSON()
    })
  }
});

var QuoteView = Backbone.View.extend({
  //el: '#quote-container',

  next: function() {
    nextPage();
    console.log('this isnt the issue');
  },
  initialize: function() {
    this.collection = new Quotes;
    currentPage = 1; // feels wrong just to stick a 1 inside of this.render
    this.render(); // I may have written render directly into initialize, but this seems the recommended technique
    console.log("view initialized", this);
  },
  /*
   Need some seperation between the view that gets the data
   and the view that pages through the data found in the data page
   this way the api won't be hit when paging through quotes
   */
  render: function() {
    var that = this;
    var promise = this.collection.fetch();
    promise.done(function() {
      that.render_five(1, that.collection)
    });
  },
  render_five: function(currentPage, currentCollection) {
    var quoteTemplate = _.template( $("#quote-template").html() ); // use underscore to make a template out of some html gotten using jQuery
    var quoteHTML = quoteTemplate({quotes : currentCollection.paginate(5, currentPage) });  // feed that template our collection
    console.log('that collection', currentCollection);
    $('#quote-container').html( quoteHTML ); // this view's el-zone needs html... let's use quoteTemplate
  }
});

var quoteView = new QuoteView;
// write a function that is called when a button is clicked
// this function should take current page and return render(currentPage++)
// looks like i need to know what the current page is

// Thinking there must be a more 'backbone' way to bind these functions
$(document).ready(function() {

  $( '#next-page').click( function() {
    currentPage++;
    quoteView.render_five(currentPage, quoteView.collection);
    console.log('currentpageis', currentPage);
  });

  $( '#previous-page').click( function() {
    currentPage--;
    quoteView.render_five(currentPage, quoteView.collection);
  });

});
