# frozen_string_literal: true

module ImportPrMetadataService
  module_function

  def call(user)
    pr_service = PullRequestService.new(user, randomize_token: true)

    begin
      pr_data = pr_service.all
    rescue GithubPullRequestService::UserDeletedError
      user_stat = UserStat.where(user_id: user.id).first

      user_stat.destroy
      return
    end

    pr_data.map do |pr|
      PRStat.where(pr_id: pr.id).first_or_create(data: pr)
    end
  end
end
