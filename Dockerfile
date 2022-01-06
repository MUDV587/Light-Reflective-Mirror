FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /lrm
COPY . .
RUN dotnet publish --runtime ubuntu.20.04-x64 -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /lrm
COPY --from=build-env /app/out .

ENV NO_CONFIG="true"
ENV TRANSPORT_CLASS="kcp2k.KcpTransport"
ENV AUTH_KEY="Secret Auth Key"
ENV TRANSPORT_PORT="7777"
ENV UPDATE_LOOP_TIME="10"
ENV UPDATE_HEARTBEAT_INTERVAL="100"
ENV RANDOMLY_GENERATED_ID_LENGTH="5"
ENV USE_ENDPOINT="true"
ENV ENDPOINT_PORT="8080"
ENV ENDPOINT_SERVERLIST="true"
ENV ENABLE_NATPUNCH_SERVER="true"
ENV NAT_PUNCH_PORT="7776"
ENV USE_LOAD_BALANCER="false"
ENV LOAD_BALANCER_AUTH_KEY="AuthKey"
ENV LOAD_BALANCER_ADDRESS="127.0.0.1"
ENV LOAD_BALANCER_PORT="7070"
ENV LOAD_BALANCER_REGION="1"
ENV KCP_NODELAY="true"
ENV KCP_INTERVAL="10"
ENV KCP_FAST_RESEND="2"
ENV KCP_CONGESTION_WINDOW="false"
ENV KCP_SEND_WINDOW_SIZE="4096"
ENV KCP_RECEIVE_WINDOW_SIZE="4096"
ENV KCP_CONNECTION_TIMEOUT="10000"

EXPOSE 7777/udp
EXPOSE 7776/udp
EXPOSE 8080

ENTRYPOINT [ "./LRM" ]
