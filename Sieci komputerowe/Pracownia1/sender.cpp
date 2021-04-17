/******************
Karolina Jeziorska
308220
******************/

#include "sender.h"
#include <arpa/inet.h>
#include <strings.h>
#include <cassert>
#include <iostream>

Sender::Sender(int s, int pid, char *addr): sockfd(s), id(pid){
    bzero (&destAddr, sizeof(destAddr));
    destAddr.sin_family = AF_INET;
    int addrConvert = inet_pton(AF_INET, addr, &destAddr.sin_addr);
    if (addrConvert == 0){
        throw std::invalid_argument("Invalid ip address");
    }
}

void Sender::send(int ttl, int seq){
    setsockopt (sockfd, IPPROTO_IP, IP_TTL, &ttl, sizeof(int));

    struct icmp header = createIcmpHeader(seq);

    ssize_t bytes_sent = sendto(
        sockfd,
        &header,
        sizeof(header),
        0,
        (struct sockaddr*) &destAddr,
        sizeof(destAddr)
    );

    if (bytes_sent < 0){
        throw std::runtime_error("Sending packet error");
    }
}

icmp Sender::createIcmpHeader(int seq){
    struct icmp header;
    header.icmp_type = ICMP_ECHO;
    header.icmp_code = 0;
    header.icmp_hun.ih_idseq.icd_id = id;
    header.icmp_hun.ih_idseq.icd_seq = seq;
    header.icmp_cksum = 0;
    header.icmp_cksum = compute_icmp_checksum((u_int16_t*) &header, sizeof(header));
    return header;
}

u_int16_t Sender::compute_icmp_checksum (const void *buff, int length){
	u_int32_t sum;
	const u_int16_t* ptr = (u_int16_t*)buff;
	assert (length % 2 == 0);
	for (sum = 0; length > 0; length -= 2)
		sum += *ptr++;
	sum = (sum >> 16) + (sum & 0xffff);
	return (u_int16_t)(~(sum + (sum >> 16)));
}