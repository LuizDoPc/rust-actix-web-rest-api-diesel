# dockerfile for rust app

FROM rust:latest as builder

WORKDIR /app

COPY . .

RUN cargo build --release

FROM debian

WORKDIR /app

RUN apt-get update && apt-get install postgresql -y

COPY --from=builder /app/target/release/rust-rest-api .

EXPOSE 8080

CMD ["./rust-rest-api"]
