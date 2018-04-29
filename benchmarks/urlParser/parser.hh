#ifndef __PARSER_H
#define __PARSER_H

#include <string>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

using namespace std;

// https://stackoverflow.com/questions/440133/how-do-i-create-a-random-alpha-numeric-string-in-c
static const char alphaNumeric[] =
        "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

#define MAX_URI_LEN 128

// Sparse matrix class
class URI
{
	public:
		// Constructor and Destructor
		URI();
		~URI();

		// Randomize method (for init)
		void Randomize();

		// Dimension wrappers
		string getURI();
		string getScheme();
		string getHost();
		string getLocation();

	private:
		string* uri;
};

URI::URI()
{
	uri = new string();
};

URI::~URI()
{
	delete uri;
};

void URI::Randomize()
{
	string* scheme = new string("https://");
	string* host = new string();
	string* hostEnd = new string(".com/");
	string* location = new string();

	srand(clock());
	uint8_t hostLen = rand()%MAX_URI_LEN + 1;
	srand(clock());
	uint8_t locationLen = rand()%MAX_URI_LEN + 1;

	for(uint8_t itr = 0; itr < hostLen; itr++)
	{
		srand(clock());
		host->append(1, alphaNumeric[rand()%sizeof(alphaNumeric)]);
	}

	for(uint8_t itr = 0; itr < locationLen; itr++)
	{
		srand(clock());
		location->append(1, alphaNumeric[rand()%sizeof(alphaNumeric)]);
	}

	*uri += *scheme;
	*uri += *host;
	*uri += *hostEnd;
	*uri += *location;

	delete scheme;
	delete host;
	delete hostEnd;
	delete location;
};

string URI::getURI()
{
	return *uri;
};

string URI::getScheme()
{
	return uri->substr(0, uri->find("://"));
};

string URI::getHost()
{
	return uri->substr(uri->find("://")+3, uri->find(".com/")-3);
};

string URI::getLocation()
{
	return uri->substr(uri->find(".com/")+5, uri->size()-1);
};

#endif