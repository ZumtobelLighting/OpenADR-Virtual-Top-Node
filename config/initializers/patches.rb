#
# The pluck() method in ActiveRecord 3.2.22.5 was causing an error:
#     NoMethodError: undefined method `columns' for [ ... ]:Array
# I couldn't figure out why, so replacing it with the implementation in AR 3.2.12
# via this monkey patch.
# (Just using Rail 3.2.12 wasn't working for other reasons, I think due to jruby 9.1,
# and the latest 3.2 seems to work better overall).
#
module ActiveRecord
    module Calculations
        def pluck(column_name)
            column_name = column_name.to_s
            klass.connection.select_all(select(column_name).arel).map! do |attributes|
              klass.type_cast_attribute(attributes.keys.first, klass.initialize_attributes(attributes))
            end
        end
    end
end
