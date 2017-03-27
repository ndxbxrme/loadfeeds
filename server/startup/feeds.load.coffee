starterFeeds = Npm.require '../../../../../../../server/startup/starter-feeds.json'
FeedParser = Npm.require 'feedparser'
request = Npm.require 'request'

Meteor.startup ->
  fetchFeed = (feed, cb) ->
    cbcount = 0
    options =
      url: feed
      headers: 
        'User-Agent': 'my podcatcher'
    isfeed = Feeds.findOne
      url:feed
    if isfeed
      console.log 'already in database'
      return cb()
    feedparser = new FeedParser()
    req = request options
    req.on 'error', Meteor.bindEnvironment (err) ->
      console.log 'req error', err
      if cbcount++ < 1
        cb()
    req.on 'response', (res) ->
      @pipe feedparser
    feedparser.on 'error', Meteor.bindEnvironment (err) ->
      console.log feed
      console.log 'feedparser error', err
      if cbcount++ < 1
        cb()
    feedparser.on 'readable', Meteor.bindEnvironment ->
      stream = feedparser
      if not feedId and stream.meta
        stream.meta.image = stream.meta.image or {}
        feedId = Feeds.insert
          url: feed
          title: stream.meta.title
          description: stream.meta.description
          image: stream.meta.image.url
          pubDate: stream.meta.pubDate
      while item = stream.read()
        if item and item['rss:enclosure'] and item['rss:enclosure']['@'] and item['rss:enclosure']['@'].url
          Items.insert
            feedId: feedId
            title: item.title
            url: item['rss:enclosure']['@'].url
            image: item.image.url
            pubDate: item.pubDate
    feedparser.on 'end', Meteor.bindEnvironment ->
      if cbcount++ < 1
        cb()
  loadFeeds = ->
    counter = 0
    fetchNext = ->
      if counter++ < starterFeeds.feeds.length
        console.log 'fetching', counter, '/', starterFeeds.feeds.length
        fetchFeed starterFeeds.feeds[counter - 1], fetchNext
      else
        console.log 'done'
    fetchNext()
  loadFeeds()