
  
   with Ada.Unchecked_Deallocation;
   use Ada;
   
   package body Queues is
   
      procedure Free_Queue_Element is
        new Unchecked_Deallocation(Queue_Element_Type,Queue_Element_Pointer);
  
     procedure Enqueue (Item: in Integer; Queue: in out Queue_Type) is
        New_Element : Queue_Element_Pointer;
     begin
        New_Element := new Queue_Element_Type' (Item, null);
        if Queue.Length = 0 then
           Queue.Front := New_Element;
        else
           Queue.Back.Link := New_Element;
        end if;
        Queue.Back := New_Element;
        Queue.Length := Queue.Length + 1;
     end Enqueue;
  
     procedure Dequeue (Item: out Integer; Queue: in out Queue_Type) is
        Old_Front: Queue_Element_Pointer;
     begin
        if Queue.Length > 0 then
           Old_Front := Queue.Front;
           Queue.Front := Old_Front.Link;
           Item := Old_Front.Data;
           Free_Queue_Element (Old_Front);  -- deallocate storage!
           Queue.Length := Queue.Length - 1;
        else
           raise Empty_Queue_Error;
        end if;
     end Dequeue;
  
     function Length (Queue: Queue_Type) return Natural is
     begin
        return Queue.Length;
  end Length;
 end Queues;
