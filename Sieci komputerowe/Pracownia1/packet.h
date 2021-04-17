/******************
Karolina Jeziorska
308220
******************/
#ifndef PACKET_H
#define PACKET_H

#include <chrono>
#include <vector>

class Packet{
public:
    bool valid;
    char* source_ip;
    bool end;
    std::chrono::steady_clock::time_point recive_time;
    Packet();
    Packet(bool valid, char *ip, bool end, std::chrono::steady_clock::time_point t);
};

bool displayPackets(std::vector<Packet> packets, std::chrono::steady_clock::time_point send_time, int hop);

#endif