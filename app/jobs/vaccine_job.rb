class VaccineJob < ApplicationJob
  # Local invocation: `jets call vaccine_job-vaccine_check --local`
  # rate "10 hours" # every 10 hours
  def vaccine_check
    client = Slack::Web::Client.new
    
    # Aventist
    begin
      url = 'https://www.adventisthealthcare.com/coronavirus-covid-19/vaccine/'
      aventist_text = Nokogiri::HTML(URI.open(url)).css('table.Border3').text
      if aventist_text !== "\r\n\r\n\r\nStatus\r\nClinic Location\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nClosed\r\n\r\n\r\nFort Washington, MD\r\nAlert Me\r\n\r\n\r\n\r\n\r\n\r\nClosed\r\n\r\n\r\nRockville, MD\r\nAlert Me\r\n\r\n\r\n\r\n\r\n\r\nClosed\r\n\r\n\r\nTakoma Park, MD\r\nAlert Me\r\n\r\n\r\n"
        client = Slack::Web::Client.new
        client.chat_postMessage(channel: '#alex-scripting-log', text: "Aventist changed: #{url}", as_user: true)
      end
    rescue
      client.chat_postMessage(channel: '#alex-scripting-log', text: "Aventist failed", as_user: true)
    end

    # Giant
    begin
      url = 'https://giantfoodsched.rxtouch.com/rbssched/program/covid19/Patient/Advisory'
      giant = Nokogiri::HTML(URI.open(url)).text
      if !giant.include?('There are currently no COVID-19 vaccine appointments available.')
        client.chat_postMessage(channel: '#alex-scripting-log', text: "Giant changed: #{url}", as_user: true)
      end
    rescue
      client.chat_postMessage(channel: '#alex-scripting-log', text: "Giant failed", as_user: true)
    end
  end
end
