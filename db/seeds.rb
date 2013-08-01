# Pricing Plans
Plan.delete_all
Plan.create(:name => "Free", :description => "Forever Free", :price => 0, :max_agent_seats => 1)
Plan.create(:name => "Starter", :description => "or you can choose to get the white labeled widget only for", :price => 14, :max_agent_seats => 1)
Plan.create(:name => "Personal", :description => "for your small personal business", :price => 29, :max_agent_seats => 5, :features => ['up to 5 agent seats', 'white labeled widget'])
Plan.create(:name => "Business", :description => "for e-commerce websites", :price => 59, :max_agent_seats => 12, :features => ['up to 12 agent seats', 'white labeled widget'])
Plan.create(:name => "Enterprise", :description => "for large sales companies", :price => 129, :max_agent_seats => 30, :features => ['up to 30 agent seats', 'white labeled widget'])
