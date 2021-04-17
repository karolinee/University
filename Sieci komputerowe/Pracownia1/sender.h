/******************
Karolina Jeziorska
308220
******************/

#ifndef SENDER_H
#define SENDER_H

#include <netinet/ip.h>
#include <netinet/ip_icmp.h>

class Sender{
    int sockfd;
    int id;
    struct sockaddr_in destAddr;
    icmp createIcmpHeader(int seq);
    u_int16_t compute_icmp_checksum(const void *buff, int length);

public:
    Sender();
    Sender(int s, int pid, char *addr);
    void send(int ttl, int seq);
};

#endif