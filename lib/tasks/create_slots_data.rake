namespace :create_slots_data do
  task :generate_slots, [:m, :n] => [:environment] do |_, args|
    # Sample command
    # rails create_slots_data:generate_slots[5,4] -> (A1 - A4, B1 - B4, ... , E1 - E4)
    m = args[:m].to_i
    n = args[:n].to_i
    max_char = ('A'.ord + m - 1).chr
    ('A'..max_char).each do |char|
      (1..n).each do |j|
        slot_name = "#{char}#{j}"
        distance = (char.ord - 'A'.ord) * 4 + j

        Slot.new(name: slot_name, distance: distance).save
      end
    end
    puts("Total #{Slot.all.count} slots created!")
  end
end
