class BaseQuery
  def find_or_create
    Blazer::Query.where(name: name).first_or_create do |stat|
      stat.description = description
      stat.statement = statement
    end
  end

  private

  def name
    self.class.name.underscore.humanize.split(' query').first
  end

  def description; end
end
