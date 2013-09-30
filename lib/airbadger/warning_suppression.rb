module Airbadger::WarningSuppression
  def without_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
    $VERBOSE = old_verbose
  end
end