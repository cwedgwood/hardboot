# use bldr (has musl-gcc) to build

FROM cwedgwood/bldr:0.01

RUN mkdir -p /build/
WORKDIR /build/
COPY . .
RUN make stripped

FROM scratch
COPY --from=0 /build/hardboot /
ENTRYPOINT ["/hardboot"]
