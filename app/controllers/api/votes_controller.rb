class Api::VotesController < Api::ApiController
  before_action :verify_poll_id
  before_action :verify_vote_type

  def create
  end

  def show
    if @type == "visitor"
      verify_ip_address
      vote = @poll.get_visitor_vote(@ip)
      if vote.present?
        respond_with_vote_given(vote.option)
      else
        respond_no_vote_given
      end
    else
      verify_user_id
      vote = @user.get_vote(@poll.id)
      if vote.present?
        respond_with_vote_given(vote.option)
      else
        respond_no_vote_given
      end
    end
  end

  def update
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

  def create_vote_for(type, option)
  end

  def update_vote_for(type, option)
  end

  def destroy_vote_for(type, option)
  end
end