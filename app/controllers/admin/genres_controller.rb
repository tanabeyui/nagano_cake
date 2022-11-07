class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = "新しいジャンルを追加しました！"
      redirect_to admin_genres_path
    else
      flash[:danger] = "ジャンル名を入力してください！"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = "ジャンル名を変更しました！"
      redirect_to admin_genres_path
    else
      flash[:danger] = "ジャンル名を入力してください！"
      render :edit
    end
  end

private


  def genre_params
    params.require(:genre).permit(:name)
  end



end
