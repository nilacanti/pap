�
�}�dc           @   s  d  d l  Z  d  d l Z d  d l Z d  d l Z d  d l Z d  d l Z d  d l Z d  d l Z d a e j	 d r� e j	 d a
 n d a
 d Z d Z d Z
 d	 Z d
 Z d e j f d �  �  YZ d
 e j f d �  �  YZ d �  Z d �  Z t t
 d � Z e d k re �  n  d S(   i����Ns	   127.0.0.1i   i'  t    i   i   i<   s   127.0.0.1:22sg   HTTP/1.1 101 XlordVpn Tunneling
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: foo

t   Serverc           B   s>   e  Z d  �  Z d �  Z d �  Z d �  Z d �  Z d �  Z RS(   c         C   sV   t  j j |  � t |  _ | |  _ | |  _ g  |  _ t  j �  |  _	 t  j �  |  _
 d  S(   N(   t	   threadingt   Threadt   __init__t   Falset   runningt   hostt   portt   threadst   Lockt   threadsLockt   logLock(   t   selfR   R   (    (    s   ws.pyR      s    				c         C   s  t  j  t  j � |  _ |  j j t  j t  j d � |  j j d � t |  j � } |  j j	 |  j
 | f � |  j j d � t |  _
 z} xv |  j
 r� y& |  j j �  \ } } | j d � Wn t  j k
 r� q� n Xt | |  | � } | j �  |  j | � q� WWd  t |  _
 |  j j �  Xd  S(   Ni   i   i    (   t   sockett   AF_INETt   soct
   setsockoptt
   SOL_SOCKETt   SO_REUSEADDRt
   settimeoutt   intR   t   bindR   t   listent   TrueR   t   acceptt   setblockingt   timeoutt   ConnectionHandlert   startt   addConnR   t   close(   R
   t   intportt   ct   addrt   conn(    (    s   ws.pyt   run   s&    	
	c         C   s#   |  j  j �  | GH|  j  j �  d  S(   N(   R   t   acquiret   release(   R
   t   log(    (    s   ws.pyt   printLog4   s    
c         C   sB   z- |  j  j �  |  j r, |  j j | � n  Wd  |  j  j �  Xd  S(   N(   R   R%   R   R	   t   appendR&   (   R
   R#   (    (    s   ws.pyR   9   s
    
	c         C   s6   z! |  j  j �  |  j j | � Wd  |  j  j �  Xd  S(   N(   R   R%   R	   t   removeR&   (   R
   R#   (    (    s   ws.pyt
   removeConnA   s    
c         C   sY   zD t  |  _ |  j j �  t |  j � } x | D] } | j �  q/ WWd  |  j j �  Xd  S(   N(   R   R   R   R%   t   listR	   R   R&   (   R
   R	   R!   (    (    s   ws.pyR   H   s    	

(   t   __name__t
   __module__R   R$   R(   R   R+   R   (    (    (    s   ws.pyR      s   						R   c           B   sG   e  Z d  �  Z d �  Z d �  Z d �  Z d �  Z d �  Z d �  Z RS(   c         C   sT   t  j j |  � t |  _ t |  _ | |  _ d |  _ | |  _	 d t
 | � |  _ d  S(   NR    s   Connection: (   R   R   R   R   t   clientClosedR   t   targetClosedt   clientt
   client_buffert   servert   strR'   (   R
   t	   socClientR3   R"   (    (    s   ws.pyR   U   s    					c         C   s�   z> y0 |  j  s2 |  j j t j � |  j j �  n  Wn n XWd  t |  _  Xz> y0 |  j s} |  j j t j � |  j j �  n  Wn n XWd  t |  _ Xd  S(   N(	   R/   R1   t   shutdownR   t	   SHUT_RDWRR   R   R0   t   target(   R
   (    (    s   ws.pyR   ^   s      	
 	c         C   s�  z�yM|  j  j t � |  _ |  j |  j d � } | d k rE t } n  |  j |  j d � } | d k ry |  j  j t � n  | d k r:|  j |  j d � } t t � d k r� | t k r� |  j | � qOt t � d k r� | t k r� |  j  j	 d � qO| j
 d � s| j
 d � r'|  j | � qO|  j  j	 d	 � n d
 GH|  j  j	 d � Wn< t k
 r�} |  j d | j
 7_ |  j j |  j � n XWd  |  j �  |  j j |  � Xd  S(
   Ns   X-Real-HostR    s   X-Splits   X-Passi    s   HTTP/1.1 400 WrongPass!

s	   127.0.0.1t	   localhosts   HTTP/1.1 403 Forbidden!

s   - No X-Real-Host!s   HTTP/1.1 400 NoXRealHost!

s
    - error: (   R1   t   recvt   BUFLENR2   t
   findHeadert   DEFAULT_HOSTt   lent   PASSt   method_CONNECTt   sendt
   startswitht	   ExceptionR'   t   strerrorR3   R(   R   R+   (   R
   t   hostPortt   splitt   passwdt   e(    (    s   ws.pyR$   q   s4     	
c         C   sj   | j  | d � } | d k r# d S| j  d | � } | | d } | j  d � } | d k rb d S| |  S(   Ns   : i����R    t   :i   s   
(   t   find(   R
   t   headt   headert   aux(    (    s   ws.pyR<   �   s    c   	      C   s�   | j  d � } | d k r< t | | d � } | |  } n% |  j d k rT d } n
 t j d } t j | | � d \ } } } } } t j | | | � |  _ t |  _	 |  j j
 | � d  S(   NRI   i����i   t   CONNECTi�  i    (   RJ   R   t   methodt   syst   argvR   t   getaddrinfoR8   R   R0   t   connect(	   R
   R   t   iR   t
   soc_familyt   soc_typet   protot   _t   address(    (    s   ws.pyt   connect_target�   s    
	
%	c         C   sZ   |  j  d | 7_  |  j | � |  j j t � d |  _ |  j j |  j  � |  j �  d  S(   Ns    - CONNECT R    (	   R'   RZ   R1   t   sendallt   RESPONSER2   R3   R(   t	   doCONNECT(   R
   t   path(    (    s   ws.pyR@   �   s    
	c   
      C   s!  |  j  |  j g } d } t } x� t r| d 7} t j | g  | d � \ } } } | ra t } n  | r� x� | D]� } yn | j t � } | r� | |  j k r� |  j  j | � n) x& | r� |  j j | � }	 | |	 } q� Wd } n PWqn t } Pqn Xqn Wn  | t k rt } n  | r! Pq! q! Wd  S(   Ni    i   i   (	   R1   R8   R   R   t   selectR:   R;   RA   t   TIMEOUT(
   R
   t   socst   countt   errorR:   RX   t   errt   in_t   datat   byte(    (    s   ws.pyR]   �   s6    	
!	
			(	   R-   R.   R   R   R$   R<   RZ   R@   R]   (    (    (    s   ws.pyR   T   s   				%			
c           C   s   d GHd GHd GHd  S(   Ns   Usage: proxy.py -p <port>s'          proxy.py -b <bindAddr> -p <port>s           proxy.py -b 0.0.0.0 -p 80(    (    (    (    s   ws.pyt   print_usage�   s    c         C   s�   y% t  j  |  d d d g � \ } } Wn( t  j k
 rO t �  t j d � n Xxd | D]\ \ } } | d k r� t �  t j �  qW | d
 k r� | a qW | d k rW t | � a qW qW Wd  S(   Ns   hb:p:s   bind=s   port=i   s   -hs   -bs   --binds   -ps   --port(   s   -bs   --bind(   s   -ps   --port(   t   getoptt   GetoptErrorRh   RP   t   exitt   LISTENING_ADDRR   t   LISTENING_PORT(   RQ   t   optst   argst   optt   arg(    (    s   ws.pyt
   parse_args�   s    %
	c         C   s�   d GHd t  GHd t t � d GHd GHt t  t � } | j �  x? t r� y t j d � WqB t k
 r| d GH| j	 �  PqB XqB Wd  S(   Ns   
:-------PythonProxy-------:
s   Listening addr: s   Listening port: s   
s   :-------------------------:
i   s   Stopping...(
   Rl   R4   Rm   R   R   R   t   timet   sleept   KeyboardInterruptR   (   R   R   R3   (    (    s   ws.pyt   main�   s    	
	

t   __main__i @  (   R   R   t   threadR_   t   signalRP   Rs   Ri   Rl   RQ   Rm   R?   R;   R`   R=   R\   R   R   R   Rh   Rr   Rv   R-   (    (    (    s   ws.pyt   <module>   s    `
B�		
