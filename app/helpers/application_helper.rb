module ApplicationHelper
  def first_name
    current_user.name.split(" ")[0]
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end
end
