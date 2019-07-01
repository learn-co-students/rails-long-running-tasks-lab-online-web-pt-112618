class SongsController < ApplicationController
  require 'csv'

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  def upload
    CSV.foreach(params[:file].path, headers: true) do |f|
      artist = Artist.find_or_create_by(name: f[1])
      Song.create(title: f[0], artist_id: artist.id)
    end
    redirect_to songs_path
  end
  #=> params[:file]
  #<ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"J+KNcbFuayL8WJgy4nb0vL3Sy5UcqRlLwgZEMRNETVxCGqyuf8iqqq48tBlsuzeHXIjFpExH0A76FRV0TC6fwQ==", "file"=>#<ActionDispatch::Http::UploadedFile:0x00007fc7d830a3c0 @tempfile=#<Tempfile:/var/folders/xb/p8tzxr991g3_v8p4b1m4rk4r0000gn/T/RackMultipart20190630-31499-ml8x9b.csv>, @original_filename="songs.csv", @content_type="text/csv", @headers="Content-Disposition: form-data; name=\"file\"; filename=\"songs.csv\"\r\nContent-Type: text/csv\r\n">, "commit"=>"Import Leads", "controller"=>"songs", "action"=>"upload"} permitted: false>

  #=> f
  #<CSV::Row "Song Clean":"Caught Up in You" "ARTIST CLEAN":".38 Special" "Release Year":"1982" "COMBINED":"Caught Up in You by .38 Special" "First?":"1" "Year?":"1" "PlayCount":"82" "F*G":"82">

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
