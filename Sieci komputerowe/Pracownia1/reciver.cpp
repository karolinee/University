/******************
Karolina Jeziorska
308220
******************/

#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <vector>
#include <sys/select.h>
#include <iostream>
#include <chrono>
#include <ctime> 

#include "reciver.h"



Reciver::Reciver(int sockfd, int pid): sockfd(sockfd), id(pid) {}

std::vector<Packet> Reciver::reciveAll(int ttl){
	fd_set descriptors;
	FD_ZERO (&descriptors);
	FD_SET (sockfd, &descriptors);
	struct timeval tv; tv.tv_sec = 1; tv.tv_usec = 0;

	int recived = 0;
	std::vector<Packet> packets;
	while(recived < 3){
		int ready = select(sockfd + 1, &descriptors, NULL, NULL, &tv);

		if (ready < 0){
			throw std::runtime_error("Reciving packets error - select");
		}

		if (ready == 0){
			break;
		}

		if (ready > 0){
			Packet p = recive(ttl);
			if (p.valid){
				recived++;
				packets.push_back(p);
			}
		}
			
	}

	return packets;
}

Packet Reciver::recive(int ttl){
	struct sockaddr_in 	sender;	
	socklen_t 			sender_len = sizeof(sender);
	u_int8_t 			buffer[IP_MAXPACKET];

	ssize_t packet_len = recvfrom (sockfd, buffer, IP_MAXPACKET, 0, (struct sockaddr*)&sender, &sender_len);
	if (packet_len < 0) {
		throw std::runtime_error("Reciving packet error - recv");
	}
	auto reciveTime = std::chrono::steady_clock::now();

	char sender_ip_str[20]; 
	inet_ntop(AF_INET, &(sender.sin_addr), sender_ip_str, sizeof(sender_ip_str));

	struct ip* ip_header = (struct ip*) buffer;
	u_int8_t* icmp_packet = buffer + 4 * ip_header->ip_hl;
	struct icmp* icmp_header = (struct icmp*) icmp_packet;

	if (icmp_header->icmp_type == ICMP_ECHOREPLY){
		int replayId = icmp_header->icmp_hun.ih_idseq.icd_id;
		int replayTtl = icmp_header->icmp_hun.ih_idseq.icd_seq;
		if (replayId == id && (replayTtl / 10) == ttl){
			return Packet(true, sender_ip_str, true, reciveTime);
		}
	}
	else if(icmp_header->icmp_type == ICMP_TIME_EXCEEDED){
		struct ip* ip_header_inside = (struct ip*) (icmp_packet + 8) ; 
		u_int8_t* icmp_packet_inside = icmp_packet + 8 + (4 * ip_header_inside->ip_hl);
		struct icmp* icmp_header_inside = (struct icmp*) icmp_packet_inside;
		int replayId = icmp_header_inside->icmp_hun.ih_idseq.icd_id;
		int replayTtl = icmp_header_inside->icmp_hun.ih_idseq.icd_seq;

		if (replayId == id && (replayTtl / 10) == ttl){
			return Packet(true, sender_ip_str, false, reciveTime);
		}
	}

	return Packet();
}