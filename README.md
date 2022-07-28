# Installing mod_wsgi on Ubuntu


## Requirements

- Ubuntu 22.04
- Apache/2.4.52
- Python 3.10.4


## Manual Steps

1. Visit your router's webapp, go to Wired Settings, select IPV4, set the IPV4 Method to Manual and enter in your desired IP address (192.168.0.## - use `hostname -I` if you're unsure what ## should be), your netmask (255.255.255.0) and your gateway IP address (found on your router, labeled as "web address").

2. Make a DHCP Reservation for your computer in order to give it a static local IP address.

3. Set up port forwarding in this step too. Add one rule for http (port 80) and another for https (port 443).

4. If you don't have a domain name, register one at no-ip.com.

5. Configure, then run `install.sh`. By running this, you will end up with an Apache instance listing on ports 80 and 443. Redirecting to HTTPS is enabled, and Python content will be served.


## Notes

Your site might not be available internally via your domain name or ip address. Instead, use https://localhost. External access will be possible.

I am not responsible for any of the undesired effects or results this code produces should you run it.
