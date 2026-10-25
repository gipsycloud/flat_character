module ApartmentsHelper
  def lifestyle_gradient(mode)
    {
      "calm"      => "from-emerald-400 to-teal-600",
      "balanced"  => "from-indigo-400 to-violet-600",
      "energetic" => "from-orange-400 to-rose-600",
      "alone"     => "from-sky-400 to-blue-600"
    }.fetch(mode.to_s, "from-slate-400 to-slate-600")
  end
end
