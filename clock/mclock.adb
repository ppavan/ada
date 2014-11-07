with Fifo;
with Ada.Text_Io; use Ada.Text_Io;
 
procedure Mclock is
   	package Int_Fifo is new Fifo(Integer);
   	use Int_Fifo;
	-- Declarations
  	Tray_one_min : Fifo_Type;-- first tray size 4
  	Tray_five_min : Fifo_Type;-- scond tray size 2
   	Tray_fifteen_min : Fifo_Type;-- third tray size 3
 	Tray_one_hour : Fifo_Type;-- fourth tray size 11
   	Tray_collector : Fifo_Type;-- this is a reserve tray size 21 (4+2+3+11+1(trigger))
  	Val : Integer;
	H : Integer;
	-- functions
	function tr(status: Integer) return Integer is
	begin
		Pop(Tray_collector, Val);
		Push(Tray_one_min,Val);
		Pop(Tray_one_min, Val);
		Push(Tray_collector, Val);
		return status;
	end;
	function print_trays(status: Integer) return Integer is
	begin
		--tray one min
		Put("Tray A (one min):     ");
		while not Is_Empty(Tray_one_min) loop
      			Pop(Tray_one_min, Val);
      			Put(Integer'Image(Val));
   		end loop;
		New_Line;
		--tray five min
		Put("Tray B (five min):    ");	
		while not Is_Empty(Tray_five_min) loop
      			Pop(Tray_five_min, Val);
      			Put(Integer'Image(Val));
   		end loop;
		New_Line;
		--tray fifteen min
		Put("Tray C (fifteen min): ");
		while not Is_Empty(Tray_fifteen_min) loop
      			Pop(Tray_fifteen_min, Val);
      			Put(Integer'Image(Val));
   		end loop;
		New_Line;
		--tray one hour
		Put("Tray D (One Hour):    ");
		while not Is_Empty(Tray_one_hour) loop
      			Pop(Tray_one_hour, Val);
      			Put(Integer'Image(Val));
   		end loop;
		New_Line;
		--tray collector
		Put("Tray E (Collector):   ");
		while not Is_Empty(Tray_collector) loop
      			Pop(Tray_collector, Val);
      			Put(Integer'Image(Val));
   		end loop;
		return status;
	end;
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
	----------------------------------
	H := tr(1);
   	H := print_trays(1);
end Mclock;
