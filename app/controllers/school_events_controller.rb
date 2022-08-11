class SchoolEventsController < ApplicationController
  def index
    matching_school_events = SchoolEvent.all

    @list_of_school_events = matching_school_events.order({ :created_at => :desc })

    render({ :template => "school_events/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_school_events = SchoolEvent.where({ :id => the_id })

    @the_school_event = matching_school_events.at(0)

    render({ :template => "school_events/show.html.erb" })
  end

  def create
    the_school_event = SchoolEvent.new
    the_school_event.school = params.fetch("query_school")
    the_school_event.event_name = params.fetch("query_event_name")
    the_school_event.event_start_date = params.fetch("query_event_start_date")
    the_school_event.host = params.fetch("query_host")
    the_school_event.estimated_cost = params.fetch("query_estimated_cost")
    the_school_event.event_end_date = params.fetch("query_event_end_date")
    the_school_event.user_id = params.fetch("query_user_id")
    the_school_event.school_event_payments_count = params.fetch("query_school_event_payments_count")

    if the_school_event.valid?
      the_school_event.save
      redirect_to("/school_events", { :notice => "School event created successfully." })
    else
      redirect_to("/school_events", { :alert => the_school_event.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_school_event = SchoolEvent.where({ :id => the_id }).at(0)

    the_school_event.school = params.fetch("query_school")
    the_school_event.event_name = params.fetch("query_event_name")
    the_school_event.event_start_date = params.fetch("query_event_start_date")
    the_school_event.host = params.fetch("query_host")
    the_school_event.estimated_cost = params.fetch("query_estimated_cost")
    the_school_event.event_end_date = params.fetch("query_event_end_date")
    the_school_event.user_id = params.fetch("query_user_id")
    the_school_event.school_event_payments_count = params.fetch("query_school_event_payments_count")

    if the_school_event.valid?
      the_school_event.save
      redirect_to("/school_events/#{the_school_event.id}", { :notice => "School event updated successfully."} )
    else
      redirect_to("/school_events/#{the_school_event.id}", { :alert => the_school_event.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_school_event = SchoolEvent.where({ :id => the_id }).at(0)

    the_school_event.destroy

    redirect_to("/school_events", { :notice => "School event deleted successfully."} )
  end
end
