# Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar los archivos del proyecto y restaurar las dependencias
COPY CRUD_Evaluacion_Mensual_Abril/ ./CRUD_Evaluacion_Mensual_Abril/
WORKDIR /app/CRUD_Evaluacion_Mensual_Abril
RUN dotnet restore

# Publicar la aplicación
RUN dotnet publish -c Release -o /app/publish

# Etapa de producción
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Configurar el punto de entrada
ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]
