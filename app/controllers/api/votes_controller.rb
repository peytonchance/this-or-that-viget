class Api::VotesController < Api::ApiController
  include ActionView::Helpers::TextHelper

  before_action :verify_poll_id
  before_action :verify_vote_type
  before_action :verify_ip_or_user
  before_action :verify_option, only: [:create, :update, :destroy]

  def create
    if @type == "visitor"
      vote = @poll.visitor_votes.new(ip_address: @ip, option: @option)
    else
      vote = @poll.votes.new(user: @user, option: @option)
    end

    if vote.save
      render json: vote_success_json(@poll, @option), status: :ok
    else
      respond_with_error("Vote unable to be saved")
    end
  end

  def show
    if @type == "visitor"
      vote = @poll.get_visitor_vote(@ip)
    else
      vote = @user.get_vote(@poll.id)
    end

    if vote.present?
      respond_with_vote_given(vote.option)
    else
      respond_no_vote_given
    end
  end

  def update
    if @type == "visitor"
      vote = @poll.visitor_votes.find_by(ip_address: @ip)
    else
      vote = @poll.votes.find_by(user_id: @user.id)
    end
    
    if vote.update(option: @option)
      render json: vote_success_json(@poll, @option), status: :ok
    else
      respond_with_error("Vote unable to be saved")
    end
  end

  def destroy
  end

  private
  def verify_ip_address
    @ip_address = params[:ip_address]
    if !@ip_address.present?
      respond_with_error("Invalid IP Address")
    end
  end

  def verify_vote_type
    @type = params[:type]
    if !@type.present?
      respond_with_error("Invalid voting type")
    end
  end

  def verify_ip_or_user
    if @type == "visitor"
      verify_ip_address
    else
      verify_user_id
    end
  end

  def verify_option
    @option = params[:option]
    if !@option.present?
      respond_with_error("No option given")
    elsif @option != "1" && @option != "0"
      respond_with_error("Invalid Option")
    else
      @option = @option.to_i
    end
  end

  def respond_no_vote_given
    render json: {
      status: "success",
      has_vote: false,
      poll: @poll.id,
      vote: {}
    }, status: :ok
  end

  def respond_with_vote_given(option)
    render json: {
      status: "success",
      has_vote: true,
      poll: @poll.id,
      vote: {
        option: option
      }
    }, status: :ok
  end

  def vote_success_json(poll, option)
    {
      "status": "success",
      "delete": false,
      "poll": poll.id,
      "optionA": poll.fraction_of_votes(0),
      "optionB": poll.fraction_of_votes(1),
      "option": option,
      "count": pluralize(poll.vote_count, "vote")
    }
  end
end