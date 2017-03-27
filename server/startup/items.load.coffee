Meteor.startup ->
  if Items.find().count() == 0
    items = [
      {
        'name': 'item 1'
      }
      {
        'name': 'item 2'
      }
    ]
    items.forEach (item) ->
      Items.insert item