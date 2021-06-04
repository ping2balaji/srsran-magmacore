# srsran-magmacore

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/shubhamtatvamasi/srsran-demo)](https://hub.docker.com/r/shubhamtatvamasi/srsran-demo)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/shubhamtatvamasi/srsran-demo?sort=semver)](https://hub.docker.com/r/shubhamtatvamasi/srsran-demo)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/shubhamtatvamasi/srsran-demo/latest)](https://hub.docker.com/r/shubhamtatvamasi/srsran-demo)
[![Docker Pulls](https://img.shields.io/docker/pulls/shubhamtatvamasi/srsran-demo)](https://hub.docker.com/r/shubhamtatvamasi/srsran-demo)
[![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/shubhamtatvamasi/srsran-demo/latest)](https://hub.docker.com/r/shubhamtatvamasi/srsran-demo)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/shubhamtatvamasi/srsran-demo)](https://hub.docker.com/r/shubhamtatvamasi/srsran-demo)


Steps:
1. Clone this repo
2. Open docker-compose.yaml and punch in the correct MME address of your AGW in the following line:
   "--enb.mme_addr=192.168.60.142"
Get MME IP address from your AGW:
```bash
ifconfig eth1 | grep 'inet ' | awk '{print $2}'
```
3. Also update the enodeb(srsenb) ip address in the following lines:
     "- --enb.gtp_bind_addr=192.168.60.1
      - --enb.s1c_bind_addr=192.168.60.1"
Get **gtp_br0** IP of AGW:
```bash
ifconfig gtp_br0 | grep 'inet ' | awk '{print $2}'
```
4. Make sure to scroll down to check and configure required settings in magma side.
5. Start srsenb and srsue using following command:
   "docker-compose up"
   This will bring up both srsenb and srsue docker containers and start establishing the call.
   On successful attach to magma core we should see some logs like below displaying allocated ue up address:
   ```bash
   srsue     | RRC Connected
   srsue     | Random Access Complete.     c-rnti=0x47, ta=0
   srsue     | Network attach successful. IP: 192.168.128.16
   srsenb    | User 0x47 connected
   srsue     | E
   ```

**Magma Side Configurations:**
1. Add APN as shown below in NMS
![image](https://user-images.githubusercontent.com/23480027/120811811-05d54400-c56a-11eb-969a-f3fbc9e07fa6.png)

2. Add a UE Subscriber as shown below in NMS
![image](https://user-images.githubusercontent.com/23480027/120812236-6fede900-c56a-11eb-9ed5-5282ea5157c8.png)

## Work in progress

start server:
```bash
iperf3 -s
```

iperf3 -c 192.168.128.12

For data traffic testing 
For testing download, ping **gtp_br0** network of AGW from UE:
```bash
docker exec -it srsue ping 192.168.128.1
```

For testing upload, ping Network attached IP of UE from AGW:
```bash
ping 192.168.128.12
```
---

## Credits 
To ShubhamTatvamasi for showing this way of testing magma 4g core

