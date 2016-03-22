class Newspaper < ActiveRecord::Base
	has_many :clips

  def init_data(rsses)
  	rsses.each do |rss|
	  	feed = Feedjira::Feed.fetch_and_parse(rss["link"])
	    add_entries(rss, feed.entries)
	    RssreaderWorker.perform_async(rss, Feedjira::Feed.fetch_and_parse(rss["link"]))
    end
  end

  private

  def add_entries(rss, entries)
    entries.each do |entry|
      unless Newspaper.exists? :link => entry.url
        news = Newspaper.new
        news.title = entry.title
        news.pubDate = entry.published
        news.description = entry.summary.gsub(/<\/?[^>]+>/, '')
        news.link = entry.url
        news.publisher = rss["name"]
        news.category = rss["category"]
        news.save
      end
    end
  end
end
