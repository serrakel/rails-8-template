class RecommendationsController < ApplicationController
  before_action(:require_user_signed_in)

  def index
    user_id = current_user.id

    @pinned = Recommendation.where({ :user_id => user_id, :status => "pinned" }).order({ :updated_at => :desc })
    @pending = Recommendation.where({ :user_id => user_id, :status => "pending" }).order({ :created_at => :desc })

    render({ :template => "recommendations/index" })
  end

  def generate
    service = BookRecommendationService.new(current_user)
    service.call

    redirect_to("/recommendations", { :notice => "New recommendations generated!" })
  end

  def pin
    the_id = params.fetch("id")

    matching_recommendations = Recommendation.where({ :id => the_id, :user_id => current_user.id })
    the_recommendation = matching_recommendations.at(0)

    if the_recommendation != nil
      the_recommendation.status = "pinned"
      the_recommendation.save
    end

    redirect_to("/recommendations", { :notice => "Recommendation pinned!" })
  end

  def reject
    the_id = params.fetch("id")

    matching_recommendations = Recommendation.where({ :id => the_id, :user_id => current_user.id })
    the_recommendation = matching_recommendations.at(0)

    if the_recommendation != nil
      the_recommendation.status = "rejected"
      the_recommendation.save
    end

    redirect_to("/recommendations", { :notice => "Recommendation rejected." })
  end

  def destroy
    the_id = params.fetch("id")

    matching_recommendations = Recommendation.where({ :id => the_id, :user_id => current_user.id })
    the_recommendation = matching_recommendations.at(0)

    if the_recommendation != nil
      the_recommendation.destroy
    end

    redirect_to("/recommendations", { :notice => "Recommendation removed." })
  end
end
