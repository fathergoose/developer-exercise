/* eslint-disable */

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
});

var QuoteView = Backbone.View.extend({
  el: '#quote-container',
  initialize: function() {
    this.collection = new Quotes;
    this.render(); // I may have written render directly into initialize, but this seems the recommended technique
    console.log("view initialized", this);
  },
  render: function() {
    var that = this;
    var promise = this.collection.fetch();
    promise.done(function() {
      var quoteTemplate = _.template( $("#quote-template").html() ); // use underscore to make a template out of some html gotten using jQuery
      var quoteHTML = quoteTemplate({quotes : that.collection.models });  // feed that template our collection
      console.log(that.collection);
      $('#quote-container').html( quoteHTML ); // this view's el-zone needs html... let's use quoteTemplate
    });
  }
});

var quoteView = new QuoteView;
