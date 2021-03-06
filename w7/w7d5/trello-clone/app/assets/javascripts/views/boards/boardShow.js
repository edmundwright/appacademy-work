TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["boards/boardShow"],

  className: "show-div",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.setWidth);
  },

  events: {
    "click button.list-new": "listNew"
  },

  setWidth: function () {
    this.$el.css("width", "" + ((this.model.lists().length + 1) * 292) + "px");
  },

  render: function () {
    this.setWidth();
    $("body").removeClass().addClass("show-body");
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);

    this.addSubview("div.lists-div", new TrelloClone.Views.ListIndex({
      collection: this.model.lists()
    }));

    this.addSubview("div.list-new", new TrelloClone.Views.ListNew({
      board: this.model
    }));

    return this;
  },

  listNew: function () {
    this.addSubview("div.list-new", new TrelloClone.Views.ListNew({
      board: this.model
    }));
  }
});
