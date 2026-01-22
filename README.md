# Despliegue-de-una-aplicaci-n-en-Cluster-con-NodeJS-y-Express

## 2. Usando los clusters
### 2.1 Primero sin clúster

Vamos a crear una maquína como hasta ahora, básica y vamos a entrar a ella con un `vagrant ssh` después de realizar un `vagrant up`.

Para agilizar un poco, dentro del bootstrap.sh, podemos dejar la carpeta necesaria creada, con `mkdir practica-cluster`, y la instalacion necesaria para realizar la práctica, como son `npm` y `nodejs` incluso realizar todo dentro del bootstrap.sh para intentar lanzarlo autmáticamente al arrancar la maquína.

Le tenemos que pasar el archivo `app.js` que hemos creado fuera de la maquína, para que lo podamos lanzar durante el arranque.
![Vagrantfile](img/app-js.png);
El contenido de este archivo es proporcionado en el pdf.