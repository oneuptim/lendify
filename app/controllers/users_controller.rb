class UsersController < ApplicationController
  def index
    render 'users/index'
  end

  def create_borrower
    user = Borrower.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], amount: params[:amount], reason: params[:reason], explanation: params[:explanation])

    if user.valid?
      @id = user.id
      session[:user_id] = user.id
      session[:user_type] = 'borrower'
      redirect_to "/borrower/#{@id}"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/register'
    end
  end

  def create_lender
    user = Lender.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], money: params[:money])

    if user.valid?
      @id = user.id
      session[:user_id] = user.id
      session[:user_type] = 'lender'
      redirect_to "/lender/#{@id}"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/register'
    end
  end

  def show_borrower
    @id = session[:user_id]
    @borrower = Borrower.find(params[:id])
    @my_lenders = Borrower.find(session[:user_id]).histories
    @total_loans = History.where(:borrower => [@id]).sum(:amount)
    render '/users/show_borrower'
  end

  def borrowers_details
    @id = params[:id]
    @borrower = Borrower.find(@id)
    @my_lenders = Borrower.find(@id).histories
    @total_loans = History.where(:borrower => [@id]).sum(:amount)
    render '/users/show_borrower'
  end

  def show_lender
    @id = session[:user_id]
    @lender = Lender.find(params[:id])
    @borrowers = Borrower.all
    @funded_loans = Lender.find(session[:user_id]).histories
    @total_funded = History.where(:lender => [@id] ).sum(:amount)
    render '/users/show_lender'
  end

  def register
    render '/users/register'
  end

  def login
    borrower = Borrower.find_by_email(params[:email])
    lender = Lender.find_by_email(params[:email])

    if borrower && borrower.authenticate(params[:password])
      @id = borrower.id
      session[:user_id] = borrower.id
      session[:user_type] = 'borrower'
      redirect_to "/borrower/#{@id}"

    elsif lender && lender.authenticate(params[:password])
      @id = lender.id
      session[:user_id] = lender.id
      session[:user_type] = 'lender'
      redirect_to "/lender/#{@id}"

    else
      flash[:errors] = "Your email or password is incorrect"
      redirect_to '/'
    end
  end

  def lend
    @id = session[:user_id]

    if params[:loan].to_i > Lender.find(@id).money
      flash[:error] = "You can't lend more than you have, adjust your loan!"
      redirect_to "/lender/#{@id}"
    elsif params[:loan].to_i < 0
      flash[:error] = "You tryna steal money bro??? C'mon now!"
      redirect_to "/lender/#{@id}"
    else
      balance = Lender.find(@id).money - params[:loan].to_i
      Lender.find(@id).update(money: balance)

      History.create(borrower: Borrower.find(params[:id]), lender: Lender.find(@id), amount: params[:loan])
      flash[:notice] = "You have successfully loaned $#{params[:loan]}"
      redirect_to "/lender/#{@id}"
    end
  end

  def thank
    @id = session[:user_id]
    @lender = Lender.find(params[:id]).name
    flash[:notice] = "Cool! We've let #{@lender} know that you appreciate them!"
    redirect_to "/borrower/#{@id}"
  end

  def logout
    session[:user_id]
    session[:user_type]
    reset_session
    flash[:notice] = "You have successfully logged out!"
    redirect_to '/'
  end
end
