module CsvHelper

  def render_csv(set, filename)
    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
    end  
    headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
  
    csv_text = set[0].class.csv_header
    set.each {|elem| csv_text += elem.to_csv }

    render :text => csv_text, :layout => false
  end

end