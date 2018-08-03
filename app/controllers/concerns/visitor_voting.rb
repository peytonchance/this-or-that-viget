module VisitorVoting
  include ActionView::Helpers::TextHelper

  def create_vote_for(option, ip)
    poll = Poll.find(params[:poll_id])
    vote = poll.visitor_votes.new(ip_address: ip, option: option)
    if vote.save
      render json: vote_success_json(poll).merge(
        "methodA": option == 0 ? "delete" : "put",
        "methodB": option == 1 ? "delete" : "put",
        "option": option
      ), status: :accepted
    else
      render json: vote_error_json, status: :unprocessable_entity
    end
  end

  def update_vote_for(option, ip)
    poll = Poll.find(params[:poll_id])
    vote = poll.visitor_votes.find_by(ip_address: ip)
    if vote.update(option: option)
      render json: vote_success_json(poll).merge(
      "methodA": option == 0 ? "delete" : "put",
      "methodB": option == 1 ? "delete" : "put",
        "option": option
    ), status: :accepted
    else
      render json: vote_error_json, status: :unprocessable_entity
    end
  end

  def destroy_vote_for(option, ip)
    poll = Poll.find(params[:poll_id])
    vote = poll.visitor_votes.find_by(ip_address: ip)
    vote.destroy
    render json: vote_success_json(poll).merge(
      "delete": true,
      "optionA": 0.5,
      "optionB": 0.5,
      "methodA": "post",
      "methodB": "post"
    ), status: :accepted
  end


  def vote_error_json
    {
      "status": "error",
      "message": "Please try again"
    }
  end

  def vote_success_json(poll)
    {
      "status": "success",
      "delete": false,
      "poll": poll.id,
      "optionA": poll.fraction_of_votes(0),
      "optionB": poll.fraction_of_votes(1),
      "pathA": poll_visitor_option_a_path(poll),
      "pathB": poll_visitor_option_b_path(poll),
      "optionAText": poll.option_a,
      "optionBText": poll.option_b,
      "count": pluralize(poll.vote_count, "vote")
    }
  end
end