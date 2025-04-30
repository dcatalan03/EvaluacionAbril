# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copiar todo el contenido del repositorio al contenedor
COPY . .

# Verificar archivos antes de hacer restore
RUN ls -la /src/CRUD_Evaluacion_Mensual_Abril

# Restaurar dependencias desde el path real del .csproj
RUN dotnet restore "./CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj"

# Publicar el proyecto
RUN dotnet publish "./CRUD_Evaluacion_Mensual_Abril/CRUD_Evaluacion_Mensual_Abril.csproj" -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "CRUD_Evaluacion_Mensual_Abril.dll"]
