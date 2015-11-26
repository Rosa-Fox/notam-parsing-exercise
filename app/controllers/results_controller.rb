class ResultsController < ApplicationController
  def index
    notams = []
    remove_lines
    paragraph
    File.open('public/notam.txt', 'r') do |f|
      f.each_line do |line|
        if line.include? 'AERODROME HOURS OF OPS/SERVICE'
          notams << line
        end
      end
      @notams = notams
    end
    @days = days
  end

  def remove_lines
    text = File.read('public/notam.txt')
    new_contents = text.gsub(/\n/, '')
    File.open('public/notam.txt', 'w') { |file| file.puts new_contents }
  end

  def paragraph
    text = File.read('public/notam.txt')
    new_contents = text.gsub(/SOURCE: EUECYIYN/, "SOURCE: EUECYIYN" + "\n")
    File.open('public/notam.txt', 'w') { |file| file.puts new_contents }
  end

  def days
    {
      'mon' => ['MON-', 'MON'],
      'tue' => ['TUE-', 'TUE', 'MON-'],
      'wed' => ['WED-', 'WED', 'TUE-', 'MON-'],
      'thu' => ['THU-', 'THU', 'WED-"', 'TUE-', 'MON-'],
      'fri' => ['FRI'],
      'sat' => ['SAT'],
      'sun' => ['SUN']
    }
  end

  def notam
    notam = params[:notam]
    path = 'public/notam.txt'
    File.open(path, 'w+') do |f|
      f.write(notam)
    end
    redirect_to results_url
  end
end
