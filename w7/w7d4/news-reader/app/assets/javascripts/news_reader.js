window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    NewsReader.feeds = new NewsReader.Collections.Feeds();
    NewsReader.feeds.fetch({ reset: true });
    new NewsReader.Routers.Router({
      $rootEl: $("#content")
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
