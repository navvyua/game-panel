class RequestPolicy
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def index?
    author_only
  end

  def show?
    author_or_receiver_or_admin
  end

  def new?
    author_only
  end

  def create?
    author_only
  end

  def destroy?
    author_or_admin_only
  end

  private

  def author_only
    @user == @report.user
  end

  def author_or_receiver_or_admin
    author_only || receiver? || user.admin?
  end

  def author_or_admin_only
    author_only || user.admin?
  end

  def receiver?
    @user == @report.character.user
  end
end
