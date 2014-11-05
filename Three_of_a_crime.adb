with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
WITH Ada.Numerics.Discrete_Random;

procedure main is
   type Player is array(1..7) of integer;
   playerlist :Player;
   guessed : Player;

   first, second, third : Integer;
   player1, player2, player3: Integer;
   trigger : Integer;
   numberofplayer : Integer;
   numberofperpetrator : Integer;
   perpetratorleft : Integer;
   guesstemp : Integer;

   SUBTYPE RandomRange IS Positive RANGE 1..7;
   PACKAGE Random_7 IS NEW Ada.Numerics.Discrete_Random
     (Result_Subtype => RandomRange);
   G: Random_7.Generator;

begin
   playerlist := (0,0,0,0,0,0,0);
   guessed := (0,0,0,0,0,0,0);
   trigger := 0;
   Random_7.Reset (Gen => G);
   perpetratorleft := 3;

   --Random generating perpetrators

   loop
      playerlist(Random_7.Random(Gen => G)) := 1;
      exit when playerlist(1)+playerlist(2)+playerlist(3)+
        playerlist(4)+playerlist(5)+playerlist(6)+playerlist(7) = 3;
   end loop;

   --Show actual perpetrator for testing
   Put("The actual perpetrator are:");
   for i in 1..7 loop
      if(playerlist(i) = 1) then
         Put(i, width => 2);
      end if;
   end loop;


   --Choose number of player
   loop
      Put_Line("Enter the number of players:");
      get(numberofplayer);
      exit when numberofplayer = 1 or numberofplayer = 2 or numberofplayer = 3;
   end loop;
   if numberofplayer = 1 then
      player1 := 1;
   elsif numberofplayer = 2 then
      player1 := 1; player2 := 1;
   else
      player1 := 1; player2 := 1; player3 := 1;
   end if;




   --Generating 3 random criminials
   while trigger = 0 loop
      numberofperpetrator := 0;
      first := Random_7.Random(Gen => G);
      loop
         second := Random_7.Random(Gen => G);
         exit when second /= first;
      end loop;
      loop
         third := Random_7.Random(Gen => G);
         exit when third /= first and third /= second;
      end loop;
      if playerlist(first) = 1 then
         numberofperpetrator := 1;
      end if;
      if playerlist(second) = 1 then
         numberofperpetrator := numberofperpetrator + 1;
      end if;
      if playerlist(third) = 1 then
         numberofperpetrator := numberofperpetrator + 1;
      end if;

      --no display of the right answer
      if numberofperpetrator /= 3 then
         New_Line;
         Put("The random selected criminals are:");
         Put(first, Width =>2);Put(",");
         Put(second, Width =>2);Put(",");
         Put(third, Width =>2);Put(".");
         New_Line;
         Put("The number of perpetrators are:");
         Put(numberofperpetrator, Width =>2);
         New_Line;


         --Game starts from player 1
         if(player1 = 1 and perpetratorleft /= 0) then
            Put_Line("Player 1, enter the number of guess, or enter 0 to pass");
            Get(guesstemp);
            if(guesstemp /= 0) then
               --make sure no repeated guesses.
               while guessed(guesstemp) = 1 loop
                  Put_Line("Do not enter repeated guesses, please enter again");
                  Get(guesstemp);
               end loop;
               guessed(guesstemp) := 1;
               if(playerlist(guesstemp) = 1) then
                  Put_Line("You made the right guess");
                  perpetratorleft := perpetratorleft - 1;
                  if(perpetratorleft = 0) then
                     Put_Line("You win!!");
                     Put("The pertrators are:");
                     for i in 1..7 loop
                        if(playerlist(i) = 1) then
                           Put(i, width => 2);
                        end if;
                     end loop;
                     trigger := 1;
                  end if;
               else
                  Put_Line("Sorry, your guess is wrong, you are out of the game");
                  player1 := 0;
                  numberofplayer := numberofplayer - 1;
                  if numberofplayer = 0 then
                     trigger := 1;
                  end if;
               end if;
            end if;
         end if; -- end player 1

         --Game starts from player 2
         if(player2 = 1 and perpetratorleft /= 0) then
            Put_Line("Player 2, enter the number of guess, or enter 0 to pass");
            Get(guesstemp);
            if(guesstemp /= 0) then
               --make sure no repeated guesses.
               while guessed(guesstemp) = 1 loop
                  Put_Line("Do not enter repeated guesses, please enter again");
                  Get(guesstemp);
               end loop;
               guessed(guesstemp) := 1;
               if(playerlist(guesstemp) = 1) then
                  Put_Line("You made the right guess");
                  perpetratorleft := perpetratorleft - 1;
                  if(perpetratorleft = 0) then
                     Put_Line("You win!!");
                     Put("The pertrators are:");
                     for i in 1..7 loop
                        if(playerlist(i) = 1) then
                           Put(i, width => 2);
                        end if;
                     end loop;
                     trigger := 1;
                  end if;
               else
                  Put_Line("Sorry, your guess is wrong, you are out of the game");
                  player2 := 0;
                  numberofplayer := numberofplayer - 1;
                  if numberofplayer = 0 then
                     trigger := 1;
                  end if;
               end if;
            end if;
         end if; -- end player 2

         --Game starts from player 3
         if(player3 = 1 and perpetratorleft /= 0) then
            Put_Line("Player 3, enter the number of guess, or enter 0 to pass");
            Get(guesstemp);
            if(guesstemp /= 0) then
               --make sure no repeated guesses.
               while guessed(guesstemp) = 1 loop
                  Put_Line("Do not enter repeated guesses, please enter again");
                  Get(guesstemp);
               end loop;
               guessed(guesstemp) := 1;
               if(playerlist(guesstemp) = 1) then
                  Put_Line("You made the right guess");
                  perpetratorleft := perpetratorleft - 1;
                  if(perpetratorleft = 0) then
                     Put_Line("You win!!");
                     Put("The pertrators are:");
                     for i in 1..7 loop
                        if(playerlist(i) = 1) then
                           Put(i, width => 2);
                        end if;
                     end loop;
                     trigger := 1;
                  end if;
               else
                  Put_Line("Sorry, your guess is wrong, you are out of the game");
                  player3 := 0;
                  numberofplayer := numberofplayer - 1;
                  if numberofplayer = 0 then
                     trigger := 1;
                  end if;
               end if;
            end if;
         end if; -- end player 3

      end if;--numberofperpetrator /= 3

   end loop;--generating loop




end main;
