if !Rails.env.production?
  ActiveRecordQueryTrace.enabled = true
end
