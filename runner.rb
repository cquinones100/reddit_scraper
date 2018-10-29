require './title.rb'
require './post.rb'

class Runner
  def titles
    @titles ||= Title.list
  end

  def run
    greet
    select_post
  end

  def greet
    puts "\n\n"
    puts 'Hello! Here are the top posts in the old reddit knitting subreddit.'
    puts "\n\n"
  end

  def select_post
    puts titles

    puts "\n\n"
    puts 'Please enter the number of the post you would like to read.'
    puts "\n\n"
    selected_index = gets.to_i
    selected_title = Title.find_by_index(selected_index)
    selected_title_href = selected_title.link

    puts "You selected #{selected_title.text} at #{selected_title_href}"

    puts "\n\n"
    puts "Loading post..."
    puts "\n\n"

    post = Post.find_or_create_by(selected_title_href)

    puts post.text

    puts "\n\n"
    puts 'Would you like to view another post? (Y/N)'
    puts "\n\n"

    view_another_post = gets.upcase.chomp

    if view_another_post == 'Y'
      select_post
    else
      puts 'Bye Bye'
    end
  end
end
