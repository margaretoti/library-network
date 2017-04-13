class ProfilesController < ApplicationController
  before_action :require_login, :allow_anyone

  def show
    checkouts = current_user.checkouts
    puts "HERE"
    puts checkouts
    checked_out_book_ids = checkouts.pluck(:book_id)

    @checked_out_books = []
    checked_out_book_ids.each do |checked_out_book_id|
      @checked_out_books << Book.find(checked_out_book_id)
    end

    # raise @checked_out_books.count.to_s

    render :show
  end
end
