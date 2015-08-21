
if [ -f /var/named/racattack ];then
  echo "named already configured in $HOSTNAME"
  exit 0
fi

chkconfig named on
touch /var/named/racattack
chmod 664 /var/named/racattack
chgrp named /var/named/racattack
chmod g+w /var/named
chmod g+w /var/named/racattack

cp /etc/named.conf /etc/named.conf.ori

grep '192.168.1.51' /etc/named.conf && echo "already configured " || sed -i -e 's/listen-on .*/listen-on port 53 { 192.168.1.51; 127.0.0.1; };/' \
-e 's/allow-query .*/allow-query     { 192.168.1.0\/24; localhost; };\n        allow-transfer  { 192.168.1.0\/24; };/' \
-e '$azone "racattack" {\n  type master;\n  file "racattack";\n};\n\nzone "in-addr.arpa" {\n  type master;\n  file "in-addr.arpa";\n};' \
/etc/named.conf


echo '$ORIGIN .
$TTL 10800      ; 3 hours
racattack               IN SOA  node1.racattack. hostmaster.racattack. (
                                101        ; serial
                                86400      ; refresh (1 day)
                                3600       ; retry (1 hour)
                                604800     ; expire (1 week)
                                10800      ; minimum (3 hours)
                                )
                        NS      node1.racattack.
                        NS      node2.racattack.
$ORIGIN racattack.
node-cluster-scan    A       192.168.1.251
                        A       192.168.1.252
                        A       192.168.1.253
node1                A       192.168.1.51
node1-priv           A       172.16.100.51
node1-vip            A       192.168.1.61
node2                A       192.168.1.52
node2-priv           A       172.16.100.52
node2-vip            A       192.168.1.62
node3                A       192.168.1.53
node3-priv           A       172.16.100.53
node3-vip            A       192.168.1.63
node4                A       192.168.1.54
node4-priv           A       172.16.100.54
node4-vip            A       192.168.1.64
node5                A       192.168.1.55
node5-priv           A       172.16.100.55
node5-vip            A       192.168.1.65
node6                A       192.168.1.56
node6-priv           A       172.16.100.56
node6-vip            A       192.168.1.66
node7                A       192.168.1.57
node7-priv           A       172.16.100.57
node7-vip            A       192.168.1.67
node8                A       192.168.1.58
node8-priv           A       172.16.100.58
node8-vip            A       192.168.1.68
node9                A       192.168.1.59
node9-priv           A       172.16.100.59
node9-vip            A       192.168.1.69
collabl1                A       192.168.1.71
collabl1-priv           A       172.16.100.71
collabl1-vip            A       192.168.1.81
collabl2                A       192.168.1.72
collabl2-priv           A       172.16.100.72
collabl2-vip            A       192.168.1.82
collabl3                A       192.168.1.73
collabl3-priv           A       172.16.100.73
collabl3-vip            A       192.168.1.83
collabl4                A       192.168.1.74
collabl4-priv           A       172.16.100.74
collabl4-vip            A       192.168.1.84
collabl5                A       192.168.1.75
collabl5-priv           A       172.16.100.75
collabl5-vip            A       192.168.1.85
collabl6                A       192.168.1.76
collabl6-priv           A       172.16.100.76
collabl6-vip            A       192.168.1.86
collabl7                A       192.168.1.77
collabl7-priv           A       172.16.100.77
collabl7-vip            A       192.168.1.87
collabl8                A       192.168.1.78
collabl8-priv           A       172.16.100.78
collabl8-vip            A       192.168.1.88
collabl9                A       192.168.1.79
collabl9-priv           A       172.16.100.79
collabl9-vip            A       192.168.1.89
collaba1                A       192.168.1.91
collaba2                A       192.168.1.92
collaba3                A       192.168.1.93
collaba4                A       192.168.1.94
collaba5                A       192.168.1.95
collaba6                A       192.168.1.96
collaba7                A       192.168.1.97
collaba8                A       192.168.1.98
collaba9                A       192.168.1.99
localhost               A       127.0.0.1
localhost.              A       127.0.0.1
node-cluster-gns.racattack.     A       192.168.1.244
$ORIGIN node.racattack.
@                       NS      node-cluster-gns.racattack.
' \
> /var/named/racattack


echo '$ORIGIN .
$TTL 10800      ; 3 hours
in-addr.arpa            IN SOA  node1.racattack. hostmaster.racattack. (
                                101        ; serial
                                86400      ; refresh (1 day)
                                3600       ; retry (1 hour)
                                604800     ; expire (1 week)
                                10800      ; minimum (3 hours)
                                )
                        NS      node1.racattack.
                        NS      node2.racattack.
$ORIGIN 20.10.10.in-addr.arpa.
51                      PTR     node1-priv.racattack.
52                      PTR     node2-priv.racattack.
53                      PTR     node3-priv.racattack.
54                      PTR     node4-priv.racattack.
55                      PTR     node5-priv.racattack.
56                      PTR     node6-priv.racattack.
57                      PTR     node7-priv.racattack.
58                      PTR     node8-priv.racattack.
59                      PTR     node9-priv.racattack.
71                      PTR     collabl1-priv.racattack.
72                      PTR     collabl2-priv.racattack.
73                      PTR     collabl3-priv.racattack.
74                      PTR     collabl4-priv.racattack.
75                      PTR     collabl5-priv.racattack.
76                      PTR     collabl6-priv.racattack.
77                      PTR     collabl7-priv.racattack.
78                      PTR     collabl8-priv.racattack.
79                      PTR     collabl9-priv.racattack.
$ORIGIN 1.168.192.in-addr.arpa.
251                     PTR     node-cluster-scan.racattack.
252                     PTR     node-cluster-scan.racattack.
253                     PTR     node-cluster-scan.racattack.
244			PTR	node-cluster-gns.racattack.
51                      PTR     node1.racattack.
52                      PTR     node2.racattack.
53                      PTR     node3.racattack.
54                      PTR     node4.racattack.
55                      PTR     node5.racattack.
56                      PTR     node6.racattack.
57                      PTR     node7.racattack.
58                      PTR     node8.racattack.
59                      PTR     node9.racattack.
61                      PTR     node1-vip.racattack.
62                      PTR     node2-vip.racattack.
63                      PTR     node3-vip.racattack.
64                      PTR     node4-vip.racattack.
65                      PTR     node5-vip.racattack.
66                      PTR     node6-vip.racattack.
67                      PTR     node7-vip.racattack.
68                      PTR     node8-vip.racattack.
69                      PTR     node9-vip.racattack.
71                      PTR     collabl1.racattack.
81                      PTR     collabl1-vip.racattack.
72                      PTR     collabl2.racattack.
82                      PTR     collabl2-vip.racattack.
73                      PTR     collabl3.racattack.
83                      PTR     collabl3-vip.racattack.
74                      PTR     collabl4.racattack.
84                      PTR     collabl4-vip.racattack.
75                      PTR     collabl5.racattack.
85                      PTR     collabl5-vip.racattack.
76                      PTR     collabl6.racattack.
86                      PTR     collabl6-vip.racattack.
77                      PTR     collabl7.racattack.
87                      PTR     collabl7-vip.racattack.
78                      PTR     collabl8.racattack.
88                      PTR     collabl8-vip.racattack.
79                      PTR     collabl9.racattack.
89                      PTR     collabl9-vip.racattack.
91                      PTR     collaba1.racattack.
92                      PTR     collaba2.racattack.
93                      PTR     collaba3.racattack.
94                      PTR     collaba4.racattack.
95                      PTR     collaba5.racattack.
96                      PTR     collaba6.racattack.
97                      PTR     collaba7.racattack.
98                      PTR     collaba8.racattack.
99                      PTR     collaba9.racattack.
' \
> /var/named/in-addr.arpa



if [ ! -f /etc/rndc.key ] ; then
  rndc-confgen -a -r /dev/urandom
  chgrp named /etc/rndc.key
  chmod g+r /etc/rndc.key
  service named restart || true
fi

# final command must return success or vagrant thinks the script failed
echo "successfully completed named steps"
