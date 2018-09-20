use strict;

use lib 'C:/Users/Simon/eclipse-workspace/NeuralNetwork';
use Node;

my @inputs = ( 1, 1 ); # there could be many inputs
my $answer = 0;
my $num_hidden_nodes = 200; # there could be many nodes in the next layer
my @hidden_node_weights = ();
my @nodes = ();
my $how_many_tests = 100;

# Create each hidden node and set the initial weight and threshold
for ( 1 .. $num_hidden_nodes ) {
     push @nodes, Node->new();
}

my $output_node = Node->new();

for ( 1 .. $how_many_tests ) {
 
 	# Now for each hidden node compute the new weight by taking all the inputs and combining it with the weight and threshold
 	my $hidden_node_num = 0;
	for my $node_obj ( @nodes ) {     

    	$node_obj->compute_weight( \@inputs );
     
    	$hidden_node_weights[$hidden_node_num] = $node_obj->{-output};
    	
    	$hidden_node_num++; 
	}

	# Take all the many outputs from the hidden nodes ( so only 1 layer of hidden nodes ) and compute the output
	
	$output_node->compute_weight( \@hidden_node_weights );
	print "Output node weight is ".$output_node->{-output}."\n";
	
	my $absolute_error = $answer - $output_node->{-output};
	my $sum_squared_errors = $absolute_error ** 2;
	my $error_gradient = $output_node->{-output} * ( 1.0 - $output_node->{-output} ) * $absolute_error;
	
	print "Result is this wrong ",$absolute_error,"\n";
	print "Sum square errors ", $sum_squared_errors,"\n";
	print "Error gradient ", $error_gradient,"\n";
	
	
	
	# Adjust weights of each hidden node by figuring out how much each one is wrong by ( below is just a dummy bit of code)
	#my $adj = ( $output_node->{-output} > $answer ) ? 0.01 : -0.01;
	my $adj =  $error_gradient;
	for ( @nodes ) {
		$_->adjust_weight( $adj );
	}
}
