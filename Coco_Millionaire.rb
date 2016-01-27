# require '.\Coco_refactor.rb'
# include CocoMethods

selling = true
money = 0.0
income = 0.0
day = 1
workday = day * 8
harvest_rate = 50 #your default harvest rate per hour
total_harvest = 0
avg_price = 5.50 #average price on average day
avg_wholesale_price = 4.50 #average wholesale price to buy on average day
demand_price = 0.0
weather_arr = [{"Sunny" => 2.0}, {"Clear" => 1.5}, {"Cloudy" => 1.0}, {"Overcast" => 0.8}, {"Showers" => 0.7}, {"Heavy Rain" => 0.6}]
tool = "shimmying up trees."
employees = 0
employee_daily_cost = 200 #daily cost per employee per harvest day
employee_harvest_rate = 10 #each employees harvest rate per hour


puts %Q{ 
                                                                                       
  .mMMMMM~.                                           
 .MMMMMMMMM~.                                      
 ^   .MMMMMMMMMMMMM~.                                
      .MMMMMMMMMMMMMMM~.       WELLCOME TO ...                           
  .MMMMMMMMMMMMMMMMMMMMm~.              
 .MMMMMMMM.MMMMMMMMm~.   ^               
 MMMM.     MMM/MMMMMm~.                  
MM,        MMM/  NMMMm~.       .8888D88D                 .88$$888D              
^          MMMM/  .NMMm^.     88.      88               88D      .8D              
           MMMM/    MM~^     88         8              D8D         8     
          .MMMM/       ^    888                        88          
          .MMMM/            888              88.888   888               88.88   
         ./MMM/.            888             88    88  888.            88.   88   
        ./MMMM/             888            888    888  888            88     88     
       ./MMMMM/             .888.        8 888    88I  8888        .= 88.   .88.    
      ./MMMMM/               .8888    .88   88    88    O888      8   O88   88.  
     //MMMM//                  .888888       88888        .888888       88888

  .$$$.  .$$ .$$. .$$   .$$   .$$  .$$$$$  .$$  .$$   .$$.   .$$ .$$$$$$ .$$$$$     
  .$$$$..$S$ .$$  .$$   .$$   .$$ .$$   $$ .$$$ .$$  .$$$$   .$$ .$$ .$$ .$$...     
  .$$.$$$.$$ .$$  .$$   .$$   .$$ .$$   $$ .$$$ $$$  .$$ $$  .$$ .$$:$$  .$$$$$     
  .$$ .$ .$$ .$$  .$$   .$$.. .$$  $$.  $$ .$$.$$$$ .$$$$$$$ .$$ .$$ \\$\\ .$$...     
  .$$    .$$ .$$  .$$$$$.$$$$$.$$   .$$$/  .$$ .$$$.$$$  .$$$.$$ .$$. \\$\\.$$$$$  


   	   Developed by: Matt King  


}

puts "What is your name?"
puts " "
name = gets.chomp
puts " "
puts "We know times are rough, #{name.capitalize}, being homeless isn't easy."
puts "Luckily you live in Miami Beach. You've found selling tasty coconuts to beachgoers to be easy money."
puts " "
puts "You'll need to start by harvesting some coconuts. Each harvest will take a full workday."
puts "On days with GOOD weather, you should hit the beach and sell them for the highest price you think you can get."
puts "If you price it too low, your inventory will sell out and you will lose out on some profits;"
puts "but if you price it too high, you won't sell as many. Choose wisely."
puts
puts "When you begin making money, you've got a few different options to reinvest.."
puts "You can upgrade your tools to increase your personal harvest rate,"
puts "you can employ other homeless people to increase your overall harvest rate,"
puts "or on POOR weather days, you can purchase coconuts at wholesale prices from other sellers."
puts "Each of these options will also take a full day for deal makings and paperwork.."
puts
puts "Try to build your wealth in the least amount of days possible - Good Luck!"
puts " "
while selling
  	if money < 1_000_000
		curr_temp = rand(55..105)
		curr_weather = 0
		weather_mult = 0
		weather_option = weather_arr.sample
		weather_option.each do |key,value|
			curr_weather = key.to_s
			weather_mult = value
		end
		temp_mult = 0
		puts "=" * 80
		puts
		puts "-- Today is Day #{day}"
		puts "-- Today's Forecast -- Temperature: #{curr_temp} Weather: #{curr_weather}"
		puts "-- You have $#{'%.2f' % money} and #{total_harvest.to_i} coconuts."
		puts "-- Personal harvest rate: #{harvest_rate} coconuts/hour"
		if employees > 0
			puts "-- Employee harvest rate: #{employees * employee_harvest_rate} coconuts/hour"
			puts "-- Number of employees: #{employees}"
		end
		puts " "
		puts "What would you like to do today, #{name.capitalize}: [H]ARVEST, [B]UY, or [S]ELL?"
		puts " "
		sell_option = gets.chomp.downcase
		case sell_option
		when "harvest" , "h"
			day += 1
			day_harvest = harvest_rate * workday
			puts " "
		    puts "-- You spend the entire day #{tool}" #CHANGE to upgrade tool
		    puts "-- By sundown, you've collected #{day_harvest} coconuts! Nice!"
		    puts " "
		    total_harvest += day_harvest
		    employee_total_cost = employees * employee_daily_cost 
		    if (employees > 0) && (employee_total_cost < money)
		    	employee_harvest = employees * employee_harvest_rate * workday
		    	total_harvest += employee_harvest
		    	money -= employee_total_cost #subtracting employee costs on harvest day
		    	# puts "test string"
		    	puts "-- Your #{employees} employees have harvested an additional #{employee_harvest} coconuts!"
		    	puts "-- #{name.capitalize} & Co.'s total harvest for the day: #{(day_harvest + employee_harvest)} coconuts."
		    	puts " "
		    elsif (employees > 0) && (employee_total_cost > money)
		    	puts "-- You don't have enough money to pay all of your employees today!"
		    	puts " "
		    else
		    end
		when "sell" , "s"
			if total_harvest > 0
				puts " "
				puts "-- You hit the beach and set up shop!"
				puts "What would you like to set your price at?"
				puts
				print "$"
				set_price = gets.to_f #users set price
				puts
			    puts "The beachgoers begin to trickle over to you.." 
			    day += 1
			    if curr_temp <= 65
			    	temp_mult = 0.75
	    			demand_mult = temp_mult * weather_mult
	    			demand_price = demand_mult * avg_price 
    				sell_ratio = (demand_price / set_price).round(2) #if the demand price is higher than set price, sell all. if lower, sell less
				    if 	sell_ratio > 1
				    	sold = total_harvest
				    	income = (sold * set_price).round(2)
				    	money += income
				    	total_harvest = 0
				    	puts " "
				    	puts "You sold #{sold} coconuts to 100% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
		    		    puts " "

				    else sell_ratio < 1
				    	sold = (total_harvest * sell_ratio).to_i
				    	income = (sold * set_price).round(2)
	 				    money += income
	 				    total_harvest -= sold
	 				    puts " "
	 				    puts "You sold #{sold} coconuts to #{(sell_ratio*100).round(2)}% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
				    	puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"		    
					    puts " "
	 				end

			    elsif curr_temp > 65 && curr_temp <= 75
			    	temp_mult = 1.0
			    	demand_mult = temp_mult * weather_mult
	    			demand_price = demand_mult * avg_price 
    				sell_ratio = (demand_price / set_price).round(2) #if the demand price is higher than set price, sell all. if lower, sell less
				     if sell_ratio > 1
				    	sold = total_harvest
				    	income = (sold * set_price).round(2)
				    	money += income
				    	total_harvest = 0
				    	puts " "
				    	puts "You sold #{sold} coconuts to 100% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "
				    else sell_ratio < 1
				    	sold = (total_harvest * sell_ratio).to_i
				    	income = (sold * set_price).round(2)
	 				    money += income
	 				    total_harvest -= sold
	 				    puts " "
	 				    puts "You sold #{sold} coconuts to #{(sell_ratio*100).round(2)}% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "
	 				end

			    elsif curr_temp > 75 && curr_temp <= 85
			    	temp_mult = 1.4
			    	demand_mult = temp_mult * weather_mult
	    			demand_price = demand_mult * avg_price 
    				sell_ratio = (demand_price / set_price).round(2) #if the demand price is higher than set price, sell all. if lower, sell less
				     if sell_ratio > 1
				    	sold = total_harvest
				    	income = (sold * set_price).round(2)
				    	money += income
				    	total_harvest = 0
				    	puts " "
				    	puts "You sold #{sold} coconuts to 100% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "
				    else sell_ratio < 1
				    	sold = (total_harvest * sell_ratio).to_i
				    	income = (sold * set_price).round(2)
	 				    money += income
	 				    total_harvest -= sold
	 				    puts " "
	 				    puts "You sold #{sold} coconuts to #{(sell_ratio*100).round(2)}% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "
	 				end

			    elsif curr_temp > 85 && curr_temp <= 95
			    	temp_mult = 1.7
			    	demand_mult = temp_mult * weather_mult
	    			demand_price = demand_mult * avg_price 
    				sell_ratio = (demand_price / set_price).round(2) #if the demand price is higher than set price, sell all. if lower, sell less
				     if sell_ratio > 1
				    	sold = total_harvest
				    	income = (sold * set_price).round(2)
				    	money += income
				    	total_harvest = 0
				    	puts " "
				    	puts "You sold #{sold} coconuts to 100% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "
				    else sell_ratio < 1
				    	sold = (total_harvest * sell_ratio).to_i
				    	income = (sold * set_price).round(2)
	 				    money += income
	 				    total_harvest -= sold
	 				    puts " "
	 				    puts "You sold #{sold} coconuts to #{(sell_ratio*100).round(2)}% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "
	 				end

			    else
			    	temp_mult = 2
			    	demand_mult = temp_mult * weather_mult
	    			demand_price = demand_mult * avg_price 
    				sell_ratio = (demand_price / set_price).round(2) #if the demand price is higher than set price, sell all. if lower, sell less
				     if sell_ratio > 1
				    	sold = total_harvest
				    	income = (sold * set_price).round(2)
				    	money += income
				    	total_harvest = 0
				    	puts " "
				    	puts "You sold #{sold} coconuts to 100% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "
				    else sell_ratio < 1
				    	sold = (total_harvest * sell_ratio).to_i
				    	income = (sold * set_price).round(2)
	 				    money += income
	 				    total_harvest -= sold
	 				    puts " "
	 				    puts "You sold #{sold} coconuts to #{(sell_ratio*100).round(2)}% of beachgoers"
				    	if sell_ratio > 1.5
				    		puts "Your coconuts sold out in the first hour! You need to raise your price much higher."
				    	elsif sell_ratio > 1.1 && sell_ratio <= 1.5
					    	puts "Your coconuts sold out by the afternoon, try raising your price a bit higher."
					    elsif sell_ratio > 0.9 && sell_ratio <= 1.1
					    	puts "Considering the weather, you priced your coconuts extremely well!"
					    elsif sell_ratio > 0.6 && sell_ratio <= 0.9
					    	puts "Your coconuts didn't sell out, try lowering your price a bit to sell more."
					    elsif sell_ratio > 0.4 && sell_ratio <= 0.6
					    	puts "You only sold about half of your coconuts, try lowering your price more."
					    else
					    	puts "You hardly sold any coconuts, you should probably lower your price much more."
					    end
					    puts
					    puts "You banked $#{'%.2f' % income} today for a total of $#{'%.2f' % money}"
					    puts " "

	 				end
	 			end
	 		else
	 			puts "You don't have any coconuts to sell!"
	 			puts " "
		    end
		when "buy" , "b"
			if money > 0
				puts " "
			    puts "-- Upgrade your harvesting tools, employ other homeless people, or buy wholesale coconuts from other sellers?"
			    puts "What would you like to buy: [U]PGRADE, [E]MPLOY, or [W]HOLESALE?"
			    puts " "
			    buy_option = gets.chomp.downcase
			    case buy_option
			    when "upgrade" , "u"
			    	puts " "
			    	puts "You have $#{money}. What kind of upgrades are you interested in?"
			    	puts " "
			    	puts "- $ 950 - Titanium alloy professional harvesting stick - +100 coconuts/hour"
			    	puts "- $ 7,500 - Golf cart with large bin attached - +250 coconuts/hour"
			    	puts "- $ 32,800 - 2016 minivan with flame decals - +700 coconuts/hour"
					puts "- $ 144,000 - Industrial coconut harvesting machine - +2,000 coconuts/hour"
					puts " "
					puts "Please choose: STICK, CART, VAN, or MACHINE?"
					puts " "
					upgrade = gets.chomp.downcase
					case upgrade #CHANGE to not be able to buy with less than cost amount / or buy two at a time.
					when "stick" , "s"
						tool = "poking at trees with your titanium alloy apparatus."
						harvest_rate += 100
						money -= 950
						day += 1
						puts "Good purchase.. this will be way easier than climbing!"
						puts " "
					when "cart" , "c"
						tool = "golf carting around and throwing coconuts in your bin"
						harvest_rate += 250
						money -= 7500
						day += 1
						puts "Nice! golf carts are way more fun to drive off the golf course."
						puts " "
					when "van" , "v"
						tool = "riding in the minivan, windows down, wind in your hair"
						harvest_rate += 700
						money -= 32800
						day += 1
						puts "aww yeah.. the flames make you harvest faster!"
						puts " "
					when "machine" , "m"
						tool = "harvesting like crazy.. this industrial machine is a beast!"
						harvest_rate += 2000
						money -= 144000
						day += 1
						puts "BOOM! Is this thing even street legal?"
						puts " "
					else
						"Sorry, that's not an option."
						puts " "
					end
				when "employ" , "e"
					puts " "
					puts "-- Good on you for wanting to help keep the economy going!"
					puts "-- Each employee will cost $#{employee_daily_cost} EVERY harvesting day (minimum wage + benefits!)"
					puts "-- and harvest at rate of #{employee_harvest_rate} coconuts/hour."
					puts "-- You can afford to hire #{(money/employee_daily_cost).to_i} employees (beware of recurring costs!)"
					puts " "
					puts "How many homeless people would you like to hire?"
					puts " "
					buy_employees = gets.chomp.to_i
					if (buy_employees * employee_daily_cost) < money
						employees += buy_employees
						money -= (buy_employees * employee_daily_cost)
						puts " "
						puts "You just hired #{buy_employees} employees!"
						puts "Employee harvest rate: #{employees * employee_harvest_rate}; Num. of employees: #{employees}."
						puts " "
						day += 1
					else (buy_employees * employee_daily_cost) > money
						puts " "
						puts "You don't have enough money to hire employees!"
						puts " "
					end
				when "wholesale" , "w"
					puts " "
					puts "-- Today looks like a pretty decent day to buy out others' inventory"
					if curr_temp < 65
						temp_mult = 0.75
						demand_mult = temp_mult * weather_mult
						market_rate = (avg_wholesale_price * demand_mult).round(2)
						puts "-- Based on today's weather, the market rate for wholesale coconuts is $#{'%.2f' % market_rate}"
						puts "-- You can afford #{(money/market_rate).to_i} coconuts."
						puts " "
						puts "How many coconuts are you looking to buy?"
						puts " "
						buy_coconuts = gets.chomp.to_i
						buy_coconut_cost = (buy_coconuts * market_rate).round(2)
						if buy_coconut_cost < money
							money -= buy_coconut_cost
							total_harvest += buy_coconuts
							day += 1
						else
							puts " "
							puts "You don't have enough money for that many!"
							puts " "
						end
					elsif curr_temp > 65 && curr_temp <= 75
						temp_mult = 1.0
						demand_mult = temp_mult * weather_mult
						demand_mult = temp_mult * weather_mult
						market_rate = (avg_wholesale_price * demand_mult).round(2)
						puts "-- Based on today's weather, the market rate for wholesale coconuts is #{'%.2f' % market_rate}"
						puts "-- You can afford #{(money/market_rate).to_i} coconuts."
						puts " "
						puts "How many coconuts are you looking to buy?"
						puts " "
						buy_coconuts = gets.chomp.to_i
						buy_coconut_cost = (buy_coconuts * market_rate).round(2)
						if buy_coconut_cost < money
							money -= buy_coconut_cost
							total_harvest += buy_coconuts
							day += 1
						else
							puts "You don't have enough money for that many!"
							puts " "
						end
					elsif curr_temp > 75 && curr_temp <= 85
						temp_mult = 1.4
						demand_mult = temp_mult * weather_mult
						demand_mult = temp_mult * weather_mult
						market_rate = (avg_wholesale_price * demand_mult).round(2)
						puts "-- Based on today's weather, the market rate for wholesale coconuts is #{'%.2f' % market_rate}"
						puts "-- You can afford #{(money/market_rate).to_i} coconuts."
						puts " "
						puts "How many coconuts are you looking to buy?"
						puts " "
						buy_coconuts = gets.chomp.to_i
						buy_coconut_cost = (buy_coconuts * market_rate).round(2)
						if buy_coconut_cost < money
							money -= buy_coconut_cost
							total_harvest += buy_coconuts
							day += 1
						else
							puts " "
							puts "You don't have enough money for that many!"
							puts " "
						end
					elsif curr_temp > 85 && curr_temp <= 95
						temp_mult = 1.7
						demand_mult = temp_mult * weather_mult
						demand_mult = temp_mult * weather_mult
						market_rate = (avg_wholesale_price * demand_mult).round(2)
						puts "-- Based on today's weather, the market rate for wholesale coconuts is #{'%.2f' % market_rate}"
						puts "-- You can afford #{(money/market_rate).to_i} coconuts."
						puts " "
						puts "How many coconuts are you looking to buy?"
						puts " "
						buy_coconuts = gets.chomp.to_i
						buy_coconut_cost = (buy_coconuts * market_rate).round(2)
						if buy_coconut_cost < money
							money -= buy_coconut_cost
							total_harvest += buy_coconuts
							day += 1
						else
							puts " "
							puts "You don't have enough money for that many!"
							puts " "
						end
					else
						temp_mult = 2
						demand_mult = temp_mult * weather_mult
						demand_mult = temp_mult * weather_mult
						market_rate = (avg_wholesale_price * demand_mult).round(2)
						puts "-- Based on today's weather, the market rate for wholesale coconuts is #{'%.2f' % market_rate}"
						puts "-- You can afford #{(money/market_rate).to_i} coconuts."
						puts " "
						puts "How many coconuts are you looking to buy?"
						puts " "
						buy_coconuts = gets.chomp.to_i
						buy_coconut_cost = (buy_coconuts * market_rate).round(2)
						if buy_coconut_cost < money
							money -= buy_coconut_cost
							total_harvest += buy_coconuts
							day += 1
						else
							puts " "
							puts "You don't have enough money for that many!"
							puts " "
						end
					end
				end
			else
				puts " "
				puts "You don't have any money to buy - go out and make some!"
				puts " "
			end	

		else
			puts " "
		    puts "Sorry, that's not an option."
		    puts " "
		end
	else
		puts " "
		puts %Q{

				Congrats, you're a 

  .$$$.  .$$ .$$. .$$   .$$   .$$  .$$$$$  .$$  .$$   .$$.   .$$ .$$$$$$ .$$$$$     
  .$$$$..$S$ .$$  .$$   .$$   .$$ .$$   $$ .$$$ .$$  .$$$$   .$$ .$$ .$$ .$$...     
  .$$.$$$.$$ .$$  .$$   .$$   .$$ .$$   $$ .$$$ $$$  .$$ $$  .$$ .$$:$$  .$$$$$     
  .$$ .$ .$$ .$$  .$$   .$$.. .$$  $$.  $$ .$$.$$$$ .$$$$$$$ .$$ .$$ \\$\\ .$$...     
  .$$    .$$ .$$  .$$$$$.$$$$$.$$   .$$$/  .$$ .$$$.$$$  .$$$.$$ .$$. \\$\\.$$$$$ 
   
		}
		puts "It only took you #{day} days to make $#{'%.2f' % (money)}!"
		puts " "
		puts "You've made a coconut empire, #{name.capitalize}! - a true rags to riches tale."
		puts " "
		puts "You're coconut empire included #{employees} employees. Woah!"
		puts " "
		selling = false
	end
end