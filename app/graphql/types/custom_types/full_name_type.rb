module Types
  module CustomTypes
    module FullNameType
      include Types::BaseInterface
      description 'Something with a full name'
      field :full_name, String, 'Full name', null: false

      def full_name
        "#{@object.first_name} #{@object.last_name}"
      end
    end
  end
end
