module EventsHelper
  def active(index)
    index==0 ? 'active'  : ''
  end

  def grid_value(count_events)
    if count_events.count <=4
      12 / count_events.count
    else
      12
    end
  end
end
