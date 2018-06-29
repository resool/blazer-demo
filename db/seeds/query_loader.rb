require Rails.root.join('db', 'seeds', 'base_query.rb')

class QueryLoader
  QUERY_DIR = Rails.root.join('db', 'seeds', 'queries')

  def call
    load_directory(QUERY_DIR)
  end

  private

  attr_reader :dashboard

  def load_directory dir
    Dir[Rails.root.join("#{dir}/*")].each do |file|
      if dashboard?(file) && dashboard.nil?
        @dashboard = load_dashboard(file)
        load_directory(file)
        @dashboard = nil
      elsif query?(file)
        load_query(file)
      end
    end
  end

  def load_dashboard(filepath)
    name = File.basename(filepath).humanize
    Blazer::Dashboard.where(name: name).first_or_create
  end

  def load_query(filepath)
    require(filepath)
    query = constantize_file(filepath).new.find_or_create
    add_query_to_dashoboard(query) if dashboard
  end

  def add_query_to_dashoboard query
    return if dashboard.queries.exists?(query.id)
    dashboard.queries << query
  end

  def dashboard? filepath
    File.directory?(filepath)
  end

  def query? filepath
    filepath.end_with?('_query.rb')
  end

  def constantize_file filepath
    filename = File.basename(filepath, '.rb')
    filename.camelcase.constantize
  end
end
