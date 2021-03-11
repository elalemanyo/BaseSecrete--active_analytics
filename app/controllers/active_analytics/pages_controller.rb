require_dependency "active_analytics/application_controller"

module ActiveAnalytics
  class PagesController < ApplicationController
    include PagesHelper

    def show
      scope = ViewsPerDay.where(site: params[:site], page: page_from_params).after(30.days.ago)
      @views_per_day = scope.order_by_date.group_by_date
      @referrers = scope.top.group_by_referrer_site

      @next_pages = ViewsPerDay.where(referrer_host: params[:site], referrer_path: page_from_params).top.group_by_page
      @previous_pages = ViewsPerDay.where(site: params[:site], page: page_from_params).top.group_by_referrer_page
    end
  end
end
