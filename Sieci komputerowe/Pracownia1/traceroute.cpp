/******************
Karolina Jeziorska
308220
******************/

#include <netinet/ip.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <iostream>
#include <unistd.h>
#include <chrono>
#include <ctime> 
#include <vector>

#include "sender.h"
#include "reciver.h"
#include "packet.h"

using namespace std;

int main(int argc, char *argv[])
{
    if(argc != 2){
        cerr << "Wrong number of arguments, give only destination IP address" << endl;
        return EXIT_FAILURE;
    }

	int sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
	if (sockfd < 0) {
        cerr << "Socket error: " << strerror(errno) << endl;
		return EXIT_FAILURE;
	}

    int pid = getpid();
    
    Sender *s;
    try{ 
        s = new Sender(sockfd, pid, argv[1]);
    }
    catch(exception &e){
        cerr << e.what() << endl;
        return EXIT_FAILURE;
    }
    
    Reciver r = Reciver(sockfd, pid);


	for (int i = 1; i <= 30; i++) {

        for(int j = 1; j <= 3; j++){
            try{
                s->send(i, i*10 + j);
            }
            catch(exception &e){
                cerr << e.what() << endl;
                return EXIT_FAILURE;
            }
        }
        
        auto sendTime = chrono::steady_clock::now();

        vector<Packet> recived = r.reciveAll(i);

        bool end = displayPackets(recived, sendTime, i);

        if (end){
            break;
        }

	}

    delete s;
	return EXIT_SUCCESS;
}