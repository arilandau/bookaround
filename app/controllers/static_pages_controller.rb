class StaticPagesController < ApplicationController
   skip_before_action :authenticate_user!, only: :home

  def home
    @physical_books = PhysicalBook.all
    @result = request.location
    @users = User.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow render_to_string(partial: "user_map_box", locals: { user: user}) # I DON'T UNDERSTAND THIS LINE
    end
    if current_user
      @closest_users = User.near(User.first)
      @closest_books = []
      @closest_users.each do |user|
        user.physical_books.each do |book|
          @closest_books << book unless book.user == current_user
        end
      end
      @closest_10_books = @closest_books.first(10)
    end
  end
end
