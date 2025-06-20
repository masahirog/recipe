module ApplicationHelper
  def options_for_select_from_enum(klass,column)
    enum_list = klass.send(column.to_s.pluralize)
    enum_list.map do | name , _value |
      [ t("enums.#{klass.to_s.underscore}.#{column}.#{name}") , name ]
    end
  end
  def text_url_to_link text
    URI.extract(text, ['https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    return text
  end
  def formatted_datetime(datetime)
    datetime.strftime("%Y年%m月%d日 %H:%M") if datetime.present?
  end
  def formatted_date(date)
    date.strftime("%-m/%-d(#{%w(日 月 火 水 木 金 土)[date.wday]})") if date.present?
  end
  def format_number(number)
    number.to_i == number ? number.to_i : number
  end

  def enum_l(model, attribute)
    I18n.t("enums.#{model.class.name.underscore}.#{attribute}.#{model.send(attribute)}")
  end
end

def format_number(number)
  # 四捨五入して整数なら整数表示、小数点以下があれば小数点以下1桁まで表示
  if number.round == number.to_i
    number.to_i.to_s
  else
    number.round(1).to_s
  end
end