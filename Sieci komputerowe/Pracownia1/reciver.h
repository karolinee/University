/******************
Karolina Jeziorska
308220
******************/
#ifndef RECIVER_H
#define RECIVER_H
#include "packet.h"
#include <vector>

class Reciver{
    int sockfd;
    int id;
    Packet recive(int ttl);

public:
    Reciver(int sockfd, int pid);
    std::vector<Packet> reciveAll(int ttl);
};

#endif