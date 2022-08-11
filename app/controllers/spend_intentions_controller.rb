class SpendIntentionsController < ApplicationController
  def index
    matching_spend_intentions = SpendIntention.all

    @list_of_spend_intentions = matching_spend_intentions.order({ :created_at => :desc })

    render({ :template => "spend_intentions/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_spend_intentions = SpendIntention.where({ :id => the_id })

    @the_spend_intention = matching_spend_intentions.at(0)

    render({ :template => "spend_intentions/show.html.erb" })
  end

  def create
    the_spend_intention = SpendIntention.new
    the_spend_intention.user_id = params.fetch("query_user_id")
    the_spend_intention.spend_intention = params.fetch("query_spend_intention")

    if the_spend_intention.valid?
      the_spend_intention.save
      redirect_to("/spend_intentions", { :notice => "Spend intention created successfully." })
    else
      redirect_to("/spend_intentions", { :alert => the_spend_intention.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_spend_intention = SpendIntention.where({ :id => the_id }).at(0)

    the_spend_intention.user_id = params.fetch("query_user_id")
    the_spend_intention.spend_intention = params.fetch("query_spend_intention")

    if the_spend_intention.valid?
      the_spend_intention.save
      redirect_to("/spend_intentions/#{the_spend_intention.id}", { :notice => "Spend intention updated successfully."} )
    else
      redirect_to("/spend_intentions/#{the_spend_intention.id}", { :alert => the_spend_intention.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_spend_intention = SpendIntention.where({ :id => the_id }).at(0)

    the_spend_intention.destroy

    redirect_to("/spend_intentions", { :notice => "Spend intention deleted successfully."} )
  end
end
