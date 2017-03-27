@Feeds = new Mongo.Collection('feeds')

Feeds.allow
  insert: (userId, feed) ->
    true
  update: (userId, feed, fields, modifier) ->
    true
  remove: (userId, feed) ->
    true
