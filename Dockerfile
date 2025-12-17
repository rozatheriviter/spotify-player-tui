FROM rust as builder
WORKDIR app
COPY . .
RUN cargo build --release --bin 1337spotify --no-default-features

FROM gcr.io/distroless/cc
# Create `./config` and `./cache` folders using WORKDIR commands.
# By default distroless/cc image doesn't have `mkdir` or similar commands.
WORKDIR /app/config
WORKDIR /app/cache
WORKDIR /app
COPY --from=builder /app/target/release/1337spotify .
CMD ["./1337spotify", "-c", "./config", "-C", "./cache"]
