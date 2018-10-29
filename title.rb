require 'nokogiri'
require 'open-uri'

class Title
  OLD_REDDIT_URL = 'http://old.reddit.com'
  SUBREDDIT_URL = '/r/legaladvice/'

  attr_reader :link, :text, :index

  @@all = []

  def self.all
    create_all_from_html if @@all.empty?

    @@all
  end

  def self.find_by_index(index)
    all.find { |title| index == title.index }
  end

  def self.list
    all.collect do |element|
      element.print
    end
  end

  def self.create_all_from_html
    doc = Nokogiri::HTML(
      open(OLD_REDDIT_URL + SUBREDDIT_URL,'User-Agent' => 'Me')
    )

    doc.css('a.title').each_with_index.collect do |element, index| 
      Title.new(
	link: element.attr('href'),
	text: element.text,
	index: index + 1
      )
    end
  end

  def initialize(link:, text:, index:)
    @link = OLD_REDDIT_URL + link
    @text = text
    @index = index

    @@all << self
  end

  def print
    "#{index}:   #{text}"
  end
end

