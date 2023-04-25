class BooksController < ApplicationController



  def index
    @books = Book.all
    @users = User.all
    @user = current_user
    @book = Book.new
  end


  def show
    @book = Book.find(params[:id])
   @newbook = Book.new
   @users = User.all
   @user = @book.user

  end

  def edit

      @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end


 def update
       @book = Book.find(params[:id])

       if @book.update(book_params)
         flash[:notice] ="You have created book successfully.."
       redirect_to book_path(@book.id)
       else
         @books=Book.all
        render :edit

       end
 end
   # 投稿データのストロングパラメータ
  def destroy
      book = Book.find(params[:id])  # データ（レコード）を1件取得
      book.destroy  # データ（レコード）を削除
      redirect_to books_path  # 投稿一覧画面へリダイレクト
  end

  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
     @books = Book.all
      @user = @book.user
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] ="You have created book successfully.."
    else
      render :index


    end
  end
 private
  def book_params
    params.require(:book).permit(:title,:body,:image,:user_id, :profile_image)
  end
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
