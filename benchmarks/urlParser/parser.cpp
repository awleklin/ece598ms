#include <iostream>
#include <vector>
#include "parser.hh"

#define ARGCOUNT 2

using namespace std;

int main(int argc, char** argv)
{
	if(argc != ARGCOUNT)
	{
		std::cout << "Error: Only 1 argument must be provided." << std::endl;
		exit(EXIT_FAILURE);
	}

	for(uint32_t itr = 0; itr < (uint32_t)atoi(argv[1]); itr++)
	{
		URI userURI = URI();
		userURI.Randomize();
		userURI.getScheme();
		userURI.getHost();
		userURI.getLocation();
	}
	return 0;
}
