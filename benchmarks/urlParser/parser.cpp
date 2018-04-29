#include <iostream>
#include <stdlib.h>
#include <boost/regex.hpp>
#include <folly/Uri.h>

#define ARGCOUNT 2

using namespace std;

int main(int argc, char** argv)
{
	if(argc != ARGCOUNT)
	{
		cout << "Error: Only 1 argument must be provided." << endl;
		exit(EXIT_FAILURE);
	}

	folly::Uri folly("https://facebook.com/asdsdf/17312647.html");
	folly.scheme();
	folly.host();
	folly.path();
}