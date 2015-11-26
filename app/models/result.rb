class Result
  def self.display_fir(notam)
    fir_index = notam.index('A)')
    range = fir_index + 2..fir_index + 6
    notam[range]
  end

  def self.get_time(notam, day)
    if notam.include? day
      day_index = notam.index(day)
      if !day.include? '-'
        range = day_index + 3..day_index + 12
        notam[range]
      else
        range = day_index + 8..day_index + 16
        notam[range]
      end
      closed(notam, range)
    end
  end

  def self.saturday(notam)
    notam[/\SAT(.*?)SUN/, 1].delete(',')
  end

  def self.closed(notam, range)
    if notam[range].include? 'CLSD'
      notam[range].slice('CLSD')
    elsif notam[range].include? 'CLOSED'
      notam[range].slice('CLOSED')
    else
      notam[range]
    end
  end

  def self.days(notam, key)
    time = get_time(notam, key)
    days = {
      'MON' =>  time,
      'MON-' => time,
      'TUE' =>  time,
      'TUE-' => time,
      'WED' =>  time,
      'WED-' => time,
      'THU' =>  time,
      'FRI' =>  time,
      'SAT' =>  saturday(notam),
      'SUN' =>  time
    }
    days[key]
  end
end
