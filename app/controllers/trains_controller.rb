class TrainsController < LoginRequiredController
  def start
    @train = Train.new
    @train.user = current_user
    @train.started_at = Time.now
    @train.save
    @questions = questions_for_train.to_a
    @questions.shuffle!
  end

  def finalize
    @train = Train.find(params[:id])
    @train.ended_at = Time.now
    score = 0
    params[:train].each do |question, answer|
      score += 1 if Question.find(question).answers.where(correct: true).first.id.to_s == answer.first
    end
    @train.score = score
    @train.save
    redirect_to root_path, notice: t('messages.controllers.trains.train_successfully_executed')
  end

  private

  def questions_for_train
    offset = rand(Question.count)
    # No treino serão apresentadas 5 questões
    Question.offset(offset).limit(5)
  end
end
