class OrderDetail < ApplicationRecord
  enum making_status: { production_not_possible: 0, production_waiting: 1, in_production: 2, production_complete: 3}
end
