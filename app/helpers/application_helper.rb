module ApplicationHelper
  def flash_classname(type)
    case type
    when "notice"
      "bg-blue-500 text-white p-3 rounded"
    when "success"
      "bg-green-500 text-white p-3 rounded"
    when "error"
      "bg-red-500 text-white p-3 rounded"
    when "alert"
      "bg-yellow-500 text-white p-3 rounded"
    else
      "bg-blue-500 text-white p-3 rounded"
    end
  end
end
