module Airbadger::WarningSuppression
  def without_warnings
    #TODO: a better approach would be to log this to an Airbadger logger
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end
end