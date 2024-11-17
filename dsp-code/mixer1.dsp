import("stdfaust.lib");

mixer = hgroup("mixer", 
          par(i,2, 
		    vgroup("chan %i", 
			  *(vslider("gain", 0, 0, 1, 0.01))
			)
		  )
		);

process = ["gain" -> mixer];