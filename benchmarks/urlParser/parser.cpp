#include <iostream>
#include <vector>
// #include "parser.hh"
#include <glog/logging.h>
#include <boost/regex.hpp>
#include <folly/Uri.h>

#define ARGCOUNT 2

using namespace std;

int main(int argc, char** argv)
{
	if(argc != ARGCOUNT)
	{
		std::cout << "Error: Only 1 argument must be provided." << std::endl;
		exit(EXIT_FAILURE);
	}

	folly::Uri folly("https://ayylmao.com/IloveyouJian");

	cout << folly.scheme() << endl;
	cout << folly.host() << endl;
	cout << folly.path() << endl;

	// for(uint32_t itr = 0; itr < (uint32_t)atoi(argv[1]); itr++)
	// {
	// 	URI userURI = URI();
	// 	userURI.Randomize();
	// 	userURI.getScheme();
	// 	userURI.getHost();
	// 	userURI.getLocation();
	// }
	return 0;
}
