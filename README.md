# apache-accesslog-parser

What motivated me to write this automation?

Most of the customers are not open to buy the access log parser which will give us concurrent requests details, response times for each request etc. So I have come up with Perl script which converts this access log in CSV format and used InfluxDB & Grafana to display the data graphically. I have used LogParser tool other than my perl script which helped me in identifying concurrent requests calculation.

Apache access log Format Supported:
"%h %D %T %F %l %u %t &quot;%r&quot; %s %b

Objective
1. Extract the information from apache access logs and convert it into CSV format.
2. This script doesn't give the concurrent request details. It does only to convert access log to CSV format.

What I am sharing?

1. Perl Script which converts the access log to CSV format.

Not Sharing?
1. How to load this CSV data into influxDB
2. How to create dashboards using grafana
3. LogParser tool details I am not posting it.

In future I'll try to share code for remaining formats of access logs as well.

Happy Learning!!
