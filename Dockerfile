# For some reason, "sdk:7.0" cannot produce a working "--runtime linux-musl-x64"
# binary... This works fine in 6.0 and no -p:PublishAot=true. So I suspect a bug
# in that area in the 7.0 preview... Using "7.0-alpine" works, so :shrug:
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

# Deps for -p:PublishAot=true
# https://docs.microsoft.com/en-us/dotnet/core/deploying/native-aot#prerequisites
RUN apk add clang gcc lld musl-dev build-base zlib-dev

# -p:StripSymbols=true needs llvm
RUN apk add llvm

WORKDIR /app
COPY ./ ./

RUN dotnet restore
RUN dotnet publish \
    --configuration Release \
    --output out \
    --runtime linux-musl-x64 \
    --framework net7.0 \
    -p:PublishAot=true \
    -p:StripSymbols=true

# custom-built BareBones linux.
FROM bb:latest AS runtime

COPY --from=build /app/out/dotnet-self-contained ./

ENTRYPOINT ["./dotnet-self-contained"]