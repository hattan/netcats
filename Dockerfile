 FROM microsoft/dotnet:2.1-sdk-alpine AS builder
 WORKDIR /source

 # caches restore result by copying csproj file separately
 COPY *.csproj .

 RUN dotnet restore

 # copies the rest of your code
 COPY . .
 RUN dotnet publish --output /app/ --configuration Release

 # Stage 2
 FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine
 WORKDIR /app
 COPY --from=builder /app .
 ENTRYPOINT ["dotnet", "netcats.dll"]