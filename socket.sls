;; -*- mode:scheme; coding:utf-8; -*-
(library (socket)
    (export make-client-socket make-server-socket
	    socket? socket-port call-with-socket
	    socket-merge-flags socket-parge-flags
	    socket-accept socket-send socket-recv socket-shutdown socket-close
	    address-family/unspecified address-family/ineternet
	    address-family/ineternet6
	    socket-domain/stream socket-domain/datagram
	    address-info/passive address-info/canonical-name
	    address-info/numeric-host address-info/ipv4-mapped
	    address-info/all address-info/address-config
	    ip-protocol/ip ip-protocol/tcp ip-protocol/udp
	    shutdown-method/read shutdown-method/write
	    shutdown-method/read&write)
    (import (socket impl)))