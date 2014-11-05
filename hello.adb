with Ada.Text_IO; use Ada.Text_IO, Queues; 
procedure Hello is
	X : Integer; 
	begin
		X := 0;
		Put(ASCII.ESC & "[2J");
		While_Loop: 
			while X <=5 loop
			delay Duration(2.0);
			Put ("Tray 1:");
			Put_Line("OOO_");
			Put_Line("Tray 2:");
			Put_Line("Tray 3:");
			Put_Line("Tray 4:");
			Put_Line("      ");
			Put_Line("      ");
			Put_Line("Reserve:");
			delay Duration(2.0); 
			Put(ASCII.ESC & "[2J");
			X := X + 1;
		end loop While_Loop;
end Hello;
