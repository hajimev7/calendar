class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
   p 'デバッグ開始'
    @blog = Blog.create!(blog_parameter)
    p params
    params[:blog][:start_time] = @blog.start_time.tomorrow
    p params
    @blog = Blog.create!(start_time: @blog.start_time.tomorrow, content: @blog.content, title: @blog.title)
    p @blog
    @blog = Blog.create!(start_time: @blog.start_time.since(4.days), content: @blog.content, title: @blog.title)
    @blog = Blog.create!(start_time: @blog.start_time.since(7.days), content: @blog.content, title: @blog.title)
    @blog = Blog.create!(start_time: @blog.start_time.since(11.days), content: @blog.content, title: @blog.title)
    @blog = Blog.create!(start_time: @blog.start_time.since(15.days), content: @blog.content, title: @blog.title)
    @blog = Blog.create!(start_time: @blog.start_time.since(20.days), content: @blog.content, title: @blog.title)
    redirect_to blogs_path
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice:"削除しました"
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_parameter)
      redirect_to blogs_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def blog_parameter
    params.require(:blog).permit(:title, :content, :start_time)
  end

end