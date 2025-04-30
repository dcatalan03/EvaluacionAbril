# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiamos todo el contenido del proyecto
COPY . .

# Restauramos dependencias
RUN dotnet restore "CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj"

# Publicamos la app
RUN dotnet publish "CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj" -c Release -o /out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /out .

# Ejecutamos la app
ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]
