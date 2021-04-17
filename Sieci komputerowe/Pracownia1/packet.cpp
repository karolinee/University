/******************
Karolina Jeziorska
308220
******************/
#include "packet.h"
#include <iostream>
#include <cstring>
Packet::Packet(): valid(false), source_ip((char*)""), end(false), recive_time(std::chrono::steady_clock::now()) {};

Packet::Packet(bool valid, char *ip, bool end, std::chrono::steady_clock::time_point t): valid(valid), source_ip(ip), end(end), recive_time(t) {};


bool displayPackets(std::vector<Packet> packets, std::chrono::steady_clock::time_point send_time, int hop){
    int num_of_packets = packets.size();
    char *ips[num_of_packets];
    bool end = false;
    std::cout << hop << ". ";

    if (num_of_packets == 0){
        std::cout << "***" <<std::endl;
    }
    else{
        float avg_time = 0;
        int i = 0;
        for(Packet p: packets){
            avg_time += std::chrono::duration<float, std::milli>(p.recive_time - send_time).count();
            ips[i++] = p.source_ip;
            if (p.end){
                end= true;
            }
        }

        for(int j = 0; j < num_of_packets; j++){
            bool print = true;
            for(int k = 0; k < j; k++){
                if(strcmp(ips[j], ips[k]) == 0){
                    print = false;
                    break;
                }
            }
            if (print){
                std::cout << ips[j] << " ";
            }
        }

        if(num_of_packets == 3){
            std::cout << avg_time/3 << " ms" << std::endl;
        }
        else{
            std::cout << "???" << std::endl;
        }
       
    }

    return end;
    
}