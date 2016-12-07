class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  autocomplete :book, :title, :full => true
  # GET /books
  # GET /books.json
  def index
    # @books = Book.paginate(:page => params[:page], :per_page => 5)
    # @books = Book.all
    if params[:search]
      if params[:search].downcase == ''
        # show no book if search box is empty
        @books = nil
      elsif params[:search].downcase == 'all'
      # if search box is "all", show all books
        @books = Book.all
      elsif params[:search]
        @books = Book.search(params[:search])
      end
    else
      # @books = Book.all
      @books = Book.order("title").all
    end
  end

  def sortedIndex
      @books = Book.order("created_at DESC").all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @post = Post.find(params[:post_id])
    @book = @post.books.create(book_params)

    if @book.post_id == nil
      
    else
      @book.post = Post.find(@book.post_id)
    end

    respond_to do |format|
      if @book.save
        format.html { redirect_to @post, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_params, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :edition, :picture, :author, :author, :isbn, :subject, :post_id)
    end
end
