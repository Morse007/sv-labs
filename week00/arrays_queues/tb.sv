		// one error i made was not make a module tb. so vsim didnt work. i used vdir to see everything compiled in work. and also type to see what i wrote in tb.sv
module tb;

// scene 1 - regfile (unpacked fixes, 5 bytes)
	initial begin
		bit [7:0] regfile[5];
		for(int i = 0; i < 5; i++)
			regfile[i] = {4'hA, i[3:0]}; // did this first {4'hA,4'hi}; but found out {4'hA,i[3:0]} is how to do it or jsut (8'hA0 + i)
		foreach(regfile[i])
			$display("regfile[%0d] = 0x%0h", i, regfile[i]); // 0xXX is shorthand for print in hex 
		$display("size = %0d", $size(regfile));
	end
	
// scene 2 - dynamic array
	initial begin
		int payload[];
		payload = new[3]; // forgot to say payload = ; instead at the start jsut had new[3]; also 3 is the number of entries
		for(int i = 0; i < 3; i++)
			payload[i] = 10 + (10 * i);
		$display("size = %0d: %0d %0d %0d", $size(payload), payload[0], payload[1], payload[2]);
		payload = new[6](payload); // puts the values at the front
		for(int j = 3; j < 6; j++)
			payload[j] = 10 + (10 * j);
		$display("size = %0d: %0d %0d %0d %0d %0d %0d", $size(payload), payload[0], payload[1], payload[2], payload[3], payload[4], payload[5]);	
	end

// scene 3 - queue
	initial begin
		byte q[$]; // did not have this at first
		byte j;
		q = {8'h11, 8'h22, 8'h33};
		q.push_front(8'hFF); // same as q = {8'hFF, q} ; need to know push_front, push_back, pop_front, pop_back
		for(int i = 0; i < 4; i++) begin //forgot to put being so the last line (display) only ran once
			j = q.pop_front; // run 4 times
			$display("0x%0h", j); // run 4 times now cause of beign end
		end
		$display("Size = %0d", $size(q)); //q.size also works
	end

// scene 4 - associative array
	initial begin
		byte mem[int]; //value name [key]
		mem[5] = 8'hDE; // write the values 
		mem[3000] = 8'hAD;
		mem[90000] = 8'hBE;
		$display("Size = %0d", mem.num());
		foreach(mem[addr]) //can create a variable in foreach; also only goes through the ones that exist
			$display(" %0d --> 0x%0h", addr, mem[addr]); // didnt know we get the key from jsut calling addr
		
		
	end
		
endmodule
