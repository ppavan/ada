with Fifo;
with Ada.Text_Io; use Ada.Text_Io;
 
procedure Mclock is
   	package Int_Fifo is new Fifo(Integer);
   	use Int_Fifo;
   	Tray_one_min : Fifo_Type;-- first tray size 4
  	Tray_five_min : Fifo_Type;-- scond tray size 2
   	Tray_fifteen_min : Fifo_Type;-- third tray size 3
   	Tray_one_hour : Fifo_Type;-- fourth tray size 11
   	Tray_collector : Fifo_Type;-- this is a reserve tray size 21 (4+2+3+11+1(trigger))
   	Val : Integer;
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
	-----------------------------------
   	while not Is_Empty(Tray_one_min) loop
      		Pop(Tray_one_min, Val);
      		Put(Integer'Image(Val));
   	end loop;
end Mclock;
