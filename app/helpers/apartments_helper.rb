module ApartmentsHelper
  def lifestyle_gradient(mode)
    {
      "calm"      => "from-emerald-400 to-teal-600",
      "balanced"  => "from-indigo-400 to-violet-600",
      "energetic" => "from-orange-400 to-rose-600",
      "alone"     => "from-sky-400 to-blue-600"
    }.fetch(mode.to_s, "from-slate-400 to-slate-600")
  end

  def lifestyle_tagline(mode)
    {
      "calm"      => "Quiet streets, low noise, and green space nearby — ideal if you want peace after a long day.",
      "balanced"  => "A bit of everything: cafés and groceries within walking distance, but calm enough to focus.",
      "energetic" => "Close to nightlife, gyms and busy areas — perfect if you love being where things happen.",
      "alone"     => "Set up for solo living: compact, private, and everything you need within reach."
    }.fetch(mode.to_s, "A comfortable place to call home.")
  end
end
