/* global Backbone */
var test = Backbone.Model.extend({ // eslint-disable-line
  initialize: function() {
    alert('hey hey hey'); // eslint-disable-line
  }
});

var Quotes = Backbone.Collection.extend({
  url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json'
});

var quotes = new Quotes();
quotes.fetch({
});
