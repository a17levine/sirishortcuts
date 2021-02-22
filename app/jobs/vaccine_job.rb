class VaccineJob < ApplicationJob
  # Local invocation: `jets call vaccine_job-vaccine_check --local`
  # rate "10 hours" # every 10 hours
  def vaccine_check
    # agent = Mechanize.new
    # page = agent.get('https://www.walgreens.com/findcare/vaccination/covid-19/location-screening')

    # Giant Pharmacy Kentlands
    # doc = Nokogiri::HTML(URI.open("https://covidinfo.reportsonline.com/covidinfo/GiantFood.html?queueittoken=e_giantfoodcovid19~q_6c97d55e-d43b-416b-b3f7-f488407aaa7d~ts_1613595067~ce_true~rt_safetynet~h_b740dd276429cdff011eac23e586685b2f8908186f6f5af6881558d67fdc6829"))
    # is_site_working = doc.text.include?('logo')
    # no_apointments_available = doc.text.include?('There are currently no COVID-19 vaccine appointments available.')
    
    # Aventist
    doc = Nokogiri::HTML(URI.open("https://www.adventisthealthcare.com/coronavirus-covid-19/vaccine/"))
    aventist_text = doc.css('table.Border3').text
    if aventist_text !== "\r\n\r\n\r\nStatus\r\nClinic Location\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nClosed\r\n\r\n\r\nFort Washington, MD\r\nAlert Me\r\n\r\n\r\n\r\n\r\n\r\nClosed\r\n\r\n\r\nRockville, MD\r\nAlert Me\r\n\r\n\r\n\r\n\r\n\r\nClosed\r\n\r\n\r\nTakoma Park, MD\r\nAlert Me\r\n\r\n\r\n"
      client = Slack::Web::Client.new
      client.chat_postMessage(channel: '#alex-scripting-log', text: "Aventist changed: https://www.adventisthealthcare.com/coronavirus-covid-19/vaccine/", as_user: true)
    end
  end
end
