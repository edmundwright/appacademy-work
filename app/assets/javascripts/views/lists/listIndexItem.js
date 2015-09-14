TrelloClone.Views.ListIndexItem = Backbone.CompositeView.extend({
  template: JST["lists/listIndexItem"],

  tagName: "li",

  className: "list",

  events: {
    "click button.card-new": "cardNew"
  },

  render: function () {
    this.$el.attr("id", "card_" + this.model.id);
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    this.addSubview("div.cards-div", new TrelloClone.Views.CardIndex({
      collection: this.model.cards()
    }))

    return this;
  },

  cardNew: function () {
    this.addSubview("div.card-new", new TrelloClone.Views.CardNew({
      list: this.model
    }));
  }
});
