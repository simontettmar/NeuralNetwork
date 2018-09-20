package Node;

use strict;

my $E = 2.71828;

sub new {
	
	my ( $this, $input_array ) = @_;
	
    my $attrib = { 
    	             -weight => rand(2),
    	             -threshold => rand(),
    	         };
   
    #print "Node object instantiated with ".$attrib->{-weight}." ".$attrib->{-threshold}."\n";
     
    bless $attrib, $this;
}

sub compute_weight {
	
	my ( $self, $input_values ) = @_;
	
	my $calc_result = 0;
	
	#print "Number of inputs is ".scalar( @{$input_values} )."\n";
	
	# Create the Summation
	for my $input_val ( @{$input_values} ) {
	
		$calc_result += ( $input_val * $self->{-weight} );
	}
	
	# Adjust result for the Threshold
	my $threshold = rand(); # this values probably should not be generated here ?
	$calc_result += ( -1 * $self->{-threshold} );
	
	# Run the result of the Summation through to Sigmoid function
	$self->{-output} = 1.0 / ( 1.0 + ( $E ** -$calc_result));
	
	#print "Weight calculated ", $self->{-output},"\n";	
}

sub adjust_weight {
	
	my ( $self, $adjustment ) = @_;
	
	$self->{-weight} -= $adjustment;
}


1;