@Items = new Mongo.Collection('items')

Items.allow
  insert: (userId, item) ->
    true
  update: (userId, item, fields, modifier) ->
    true
  remove: (userId, item) ->
    true
