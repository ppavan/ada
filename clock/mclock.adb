with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones; use Ada.Calendar.Time_Zones;
with Fifo;
with Ada.Text_Io; use Ada.Text_Io;
 
procedure Mclock is
   	package Int_Fifo is new Fifo(Integer);
   	use Int_Fifo;
	-- Declarations
	-- FIFO Declarations
  	Tray_one_min : Fifo_Type;-- first tray size 4
  	Tray_five_min : Fifo_Type;-- scond tray size 2
   	Tray_fifteen_min : Fifo_Type;-- third tray size 3
 	Tray_one_hour : Fifo_Type;-- fourth tray size 11
   	Tray_collector : Fifo_Type;-- this is a reserve tray size 21 (4+2+3+11+1(trigger))
  	-- temporary variables
	Val : Integer;
	Temp : Integer;
	ptemp : Integer;
	H : Integer;
	l : Integer;
	-- flags
	is_one_min_full : Integer;
	is_five_min_full : Integer;
	is_fifteen_min_full : Integer;
	is_one_hour_full : Integer;
	-- size variables
	size_of_one_min : Integer;
	size_of_five_min : Integer;
	size_of_fifteen_min : Integer;
	size_of_one_hour : Integer;
	size_of_collector : Integer;
	Now : Time := Clock;
	-- functions
	function push_to_one_min(status: Integer) return Integer is
	begin
		Pop(Tray_collector, Val);
		Pop(Tray_one_min, Temp);
		Push(Tray_one_min,Val);
		Push(Tray_collector, Temp);
		--is_one_min_full := 1;
		-- once this is full set the flag
		-- if flag is set then reset this list and call push_to_five_min
		return status;
	end;
	function push_to_five_min(status: Integer) return Integer is
	begin
		--pop from min list and push here and pop a null from here and push to 
		--collector
	end;
	-- Initial tray setup start -----------------------------------
	function initial_tray_setup(status: Integer) return Integer is
	begin
		-- Loading the Tray for their sizes
   		for I in 1..4 loop
      			Push(Tray_one_min, 0);
   		end loop;
		for I in 1..2 loop
			Push(Tray_five_min, 0);
   		end loop;
		for I in 1..3 loop
			Push(Tray_fifteen_min, 0);
		end loop;
		for I in 1..11 loop
			Push(Tray_one_hour, 0);
		end loop;
		for I in 1..21 loop
			Push(Tray_collector, 1);
		end loop;

		return status;
	end;
	-- Initial tray setup end -------------------------------------
	-- Display function start -------------------------------------
	function print_trays(status: Integer) return Integer is
	begin
		-- setup sizes
		size_of_one_min := 4;
		size_of_five_min := 2;
		size_of_fifteen_min := 3;
		size_of_one_hour := 11;
		size_of_collector := 21;
		--------------
		--tray one min
		Put("Tray A (one min):     ");
		for X in 1..size_of_one_min loop
      			Pop(Tray_one_min, ptemp);
      			Put(Integer'Image(ptemp));
			Push(Tray_one_min, ptemp);
   		end loop;
		New_Line;
		--tray five min
		Put("Tray B (five min):    ");	
		for X in 1..size_of_five_min loop
      			Pop(Tray_five_min, Val);
      			Put(Integer'Image(Val));
			Push(Tray_five_min, Val);
   		end loop;
		New_Line;
		--tray fifteen min
		Put("Tray C (fifteen min): ");
		for X in 1..size_of_fifteen_min loop
      			Pop(Tray_fifteen_min, Val);
      			Put(Integer'Image(Val));
			Push(Tray_fifteen_min, Val);
   		end loop;
		New_Line;
		--tray one hour
		Put("Tray D (One Hour):    ");
		for X in 1..size_of_one_hour loop
      			Pop(Tray_one_hour, Val);
      			Put(Integer'Image(Val));
			Push(Tray_one_hour, Val);
   		end loop;
		New_Line;
		--tray collector
		Put("Tray E (Collector):   ");
		for X in 1..size_of_collector loop
      			Pop(Tray_collector, Val);
      			Put(Integer'Image(Val));
			Push(Tray_collector, Val);
   		end loop;
		return status;
	end;
	-- Display function end -----------------------------------------
	-- clear screen function start here
	function clear_screen(status: Integer) return Integer is
	begin
		Ada.Text_IO.Put(ASCII.ESC & "[2J");
		return status;
	end;
	-- clear screen function end
begin	-- main here
	H := initial_tray_setup(1);
	-- Setup flags
	is_one_min_full := 0;
	is_five_min_full := 0;
	is_fifteen_min_full := 0;
	is_one_hour_full := 0;
	--------------
	H := clear_screen(1);
	l := 0;
	for I in 1..5 loop
		Put_line(Image(Date => Now, Time_Zone => -7*60));
		H := print_trays(1);
		delay Duration(1.0);--print and wait for a sec
		H := clear_screen(1);
		delay Duration(1.0);--clear and wait for a sec
		H := push_to_one_min(1);
		New_Line;
	end loop;
end Mclock;
