class WordCountingJob
  include SuckerPunch::Job

  def perform(event)
    WordCountingHandler.handle(event[:content], event[:type])
  end
end