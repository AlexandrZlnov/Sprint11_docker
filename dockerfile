FROM golang:latest AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download 

COPY  *.go *.db ./

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

RUN go build -o parcel_tracker


FROM gcr.io/distroless/base-debian10

WORKDIR /app

COPY tracker.db ./

COPY --from=builder app/parcel_tracker ./

CMD ["./parcel_tracker"]
