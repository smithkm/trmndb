class Specialty
  attr_reader :title
  attr_reader :abbr_lng
  attr_reader :abbr_sht
  attr_reader :id

  def initialize(title, abbr_lng, abbr_sht, id)
    @title=title
    @abbr_lng=abbr_lng
    @abbr_sht=abbr_sht
    @id=id
  end

  def base_title()
    title
  end
  def petty_title()
    "#{title} Petty Officer"
  end
  def chief_title()
    "Chief #{title}"
  end
  
  def base_abbr()
    abbr_lng
  end
  def petty_abbr()
    "#{abbr_sht}P"
  end
  def chief_abbr()
    "C#{abbr_lng}"
  end

  CLASS=[nil,'1st','2nd','3rd']
  CHIEF=['Senior','Master', 'Senior Master']
  CHIEF_ABBR=['S','M', 'SM']
 
  def gtitle(level)
    case level
    when 1..3
      "#{base_title} #{CLASS[4-level]} Class"
    when 4..6
      "#{petty_title} #{CLASS[7-level]} Class"
    when 7
      chief_title
    when 8..10
      "#{CHIEF[level-8]} #{chief_title}"
    end
  end
  def gabbr(level)
    case level
    when 1..3
      "#{base_abbr}#{4-level}"
    when 4..6
      "#{petty_abbr}#{7-level}"
    when 7
      chief_abbr
    when 8..10
      "#{CHIEF_ABBR[level-8]}#{chief_abbr}"
    end
  end
end

class Mate < Specialty
  attr_reader :suffix

  def initialize(title, suffix, abbr, id)
    super(title, abbr, abbr[0..-1], id)
    @suffix=suffix
  end

  def base_title()
    if(suffix.nil?)
      title
    else
      "#{title} #{suffix}"
    end
  end
  def petty_title()
    "#{title} Mate"
  end
  def chief_title()
    "Chief #{title} Mate"
  end
  def base_abbr()
    abbr_lng
  end
  def petty_abbr()
    "#{abbr_sht}M"
  end
  def chief_abbr()
    "C#{abbr_sht}M"
  end
end

class PossessiveMate < Specialty
  attr_reader :suffix

  def base_title()
    title
  end
  def petty_title()
    "#{title}'s Mate"
  end
  def chief_title()
    "Chief #{title}'s Mate"
  end
  def base_abbr()
    abbr_lng
  end
  def petty_abbr()
    "#{abbr_sht}M"
  end
  def chief_abbr()
    "C#{abbr_sht}M"
  end
end

SPECS=[
  PossessiveMate.new("Boatswain", "BT", "B", 30),
  Mate.new("Master-at Arms", nil, "MAA", 31),
  Mate.new("Operations", "Specialist", "OPS", 25),
  Mate.new("Intelligence", "Specialist", "INS", 26),
  Specialty.new("Personnelman", "PN", "PN", 1),
  Specialty.new("Navy Counselor", "NC", "NC", 2),
  Specialty.new("Steward", "SD", "SD", 3),
  Specialty.new("Yeoman", "YN", "YN", 4),
  Specialty.new("Storekeeper", "SK", "SK", 20),
  Specialty.new("Disbursing Clerk", "DC", "D", 21),
  Specialty.new("Ship's Serviceman", "SHS", "SS", 22),
  Mate.new("Fire Control", "Technician", "FCT", 8),
  Mate.new("Electronic Warfare", "Technician", "EWT", 9),
  Mate.new("Tracking", "Specialist", "TS", 10),
  Mate.new("Sensor", "Technician", "ST", 32),
  Mate.new("Missile", "Technician", "MST", 27),
  Mate.new("Beam Weapons", "Technician", "BWT", 28),
  PossessiveMate.new("Gunner", "GN", "G", 29),
  Mate.new("Impeller", "Technician", "IT", 14),
  Mate.new("Power", "Technician", "PWT", 15),
  Mate.new("Gravitics", "Technician", "GVT", 16),
  Mate.new("Environmental", "Technician", "ENT", 17),
  Mate.new("Hydroponics", "Technician", "HYT", 18),
  Mate.new("Damage Control", "Technician", "DCT", 19),
  Mate.new("Data Systems", "Technician", "DST", 11),
  Mate.new("Electronics", "Technician", "ET", 12),
  Mate.new("Communications", "Technician", "CT", 13),
  Specialty.new("Helmsman", "HM", "HM", 6),
  Mate.new("Plotting", "Specialist", "PS", 7),
  Specialty.new("Coxswain", "COX", "CX", 5),
  Specialty.new("Corpsman", "CR", "CR", 23),
  Specialty.new("Sick Berth Attendant", "SBA", "SB", 24),
]

puts <<EOS
BEGIN;
LOCK TABLE rating IN SHARE ROW EXCLUSIVE MODE;
delete from only rating;
EOS

SPECS.each do |s|
  id_str = s.id.to_s.rjust(2,'0')
  (1..10).each do |g|
    g_str = g.to_s.rjust(2,'0')
    id_str = s.id.to_s.rjust(2,'0')
    school = case g
             when 1..6
               'A'
             else
               'C'
             end
    puts "insert into rating(branch, grade, specialty, title, abbreviation, requires) values ('RMN', 'E-#{g_str}', #{s.id},'#{s.gtitle(g).gsub("'","''")}', '#{s.gabbr(g).gsub("'","''")}', 'SIA-SRN-#{id_str}#{school}');"
  end

  puts "insert into rating(branch, grade, specialty, title, abbreviation, requires) values ('RMN', 'E+10', #{s.id},'#{s.gtitle(10).gsub("'","''")} of the Navy', '#{s.gabbr(10).gsub("'","''")}otN', 'SIA-SRN-#{id_str}C');" if(s.title=="Boatswain")

end

puts <<EOS
COMMIT;
EOS
