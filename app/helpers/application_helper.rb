module ApplicationHelper
  def saved_job_ids
    @saved_job_ids ||= current_user ? current_user.saved_jobs.pluck(:job_listing_id) : []
  end

  def favorite_apartment_map
    @favorite_apartment_map ||= current_user ? current_user.favorites.index_by(&:apartment_id) : {}
  end

  def crawl_status_badge(session)
    styles = {
      "completed" => "bg-emerald-100 text-emerald-700",
      "failed"    => "bg-red-100 text-red-700",
      "running"   => "bg-amber-100 text-amber-700"
    }
    content_tag :span, session.status.capitalize,
      class: "rounded-full px-2.5 py-0.5 text-xs font-semibold #{styles.fetch(session.status, 'bg-slate-100 text-slate-700')}"
  end
end
