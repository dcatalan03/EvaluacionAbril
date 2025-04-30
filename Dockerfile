# Etapa de build con .NET 8 SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . .  # Copia TODO lo del repo



# Restaurar paquetes desde la ruta real
RUN dotnet restore "./CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj"

# Publicar en modo release
RUN dotnet publish "./CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj" -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]
