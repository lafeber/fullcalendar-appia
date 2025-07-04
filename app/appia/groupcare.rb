module Appia
  # This module is used to access the Appia API.
  # It provides methods to get the Appia client and perform requests.
  module GroupCare
    extend ActiveSupport::Concern

    included do
      # Include the AppiaClient module to use its methods.
      include AppiaClient
    end

    # Returns a Reynard::Context instance for performing API requests.
    def appia
      AppiaClient.client
    end
  end
end
