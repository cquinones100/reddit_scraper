require 'nokogiri'
require 'open-uri'

class Post
  @@all = []

  def self.find_or_create_by(href)
    post = Post.find_by_href(href)

    if post.nil?
      Post.new(href: href)
    else
      post
    end
  end

  def self.find_by_href(href)
    @@all.find { |post| href == post.href }
  end

  attr_reader :href, :text

  def initialize(href:)
    @href = href
    @text = text

    @@all << self
  end

  def text
    @text ||= Nokogiri::HTML(open(href,'User-Agent' => 'Me'))
      .css('div.expando')
      .text
  end
end

