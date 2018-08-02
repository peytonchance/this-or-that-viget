class CommentsController < ApplicationController
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper

  def create
    if user_signed_in?
      @poll = Poll.find(params[:poll_id])
      @comment = @poll.comments.new(comment_param.merge(user: current_user))
      if @comment.save
        @form_comment_id = @comment.id
        render json: {
          "status": "success",
          "id": @comment.id,
          "content": comment_div
          }, status: :accepted
      else
        render json: {
          "status": "error",
          "message": comment_error_messages.to_s
          }, status: :unprocessable_entity
      end
    else
      render json: {
        "status": "error",
        "message": "<p>You must login to comment.<p>"
        }, status: :precondition_failed 
    end

  end
  
  def update
    comment = Poll.find(params[:poll_id]).comments.find(params[:id])
    if comment.update(body: params[:body])
      render json: {
        status: "success",
        id: comment.id,
        body: comment.body
      }, status: :accepted
    else
      render json: {
        status: "error",
        message: "<p>Body cannot be blank.</p>"
        }, status: :unprocessable_entity
    end
  end
    
  def destroy
    session[:return_to] ||= request.referer
    
    comment = Poll.find(params[:poll_id]).comments.find(params[:id])
    comment.destroy
    
    redirect_to session.delete(:return_to)
  end

  private
  def comment_param
    params.permit(:body)
  end

  def comment_error_messages
    if @comment
      return "" if @comment.errors.empty?

      messages = @comment.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
    end
  end

  def comment_div
    "<div id='comment-#{@comment.id}' class='comments__comment'>
      <p class='comments__comment__username'>#{@comment.user.username}</p>
      <div id='comment-form-wrapper-#{@comment.id}' class='comments__new-comment'>
        
      </div>
      <p id='comment-body-#{@comment.id}' class='comments__comment__text'>#{@comment.body}</p>
      <a class='edit-comment' id='comment-edit-#{@comment.id}' commentID='#{@comment.id}' href='javascript:void(0)'>Edit</a>
      <a class='' id='comment-delete-#{@comment.id}' rel='nofollow' data-method='delete' href='#{poll_comment_path(@comment.poll, @comment)}'>Delete</a>
    </div>"
  end
end
