# Despliegue-de-una-aplicaci-n-en-Cluster-con-NodeJS-y-Express

## 2. Usando los clusters
### 2.1 Primero sin clúster

Vamos a crear una maquína como hasta ahora, básica y vamos a entrar a ella con un `vagrant ssh` después de realizar un `vagrant up`.

Para agilizar un poco, dentro del bootstrap.sh, podemos dejar la carpeta necesaria creada, con `mkdir practica-cluster`, y la instalacion necesaria para realizar la práctica, como son `npm` y `nodejs` incluso realizar todo dentro del bootstrap.sh para intentar lanzarlo autmáticamente al arrancar la maquína.

Le tenemos que pasar el archivo `app.js` que hemos creado fuera de la maquína, para que lo podamos lanzar durante el arranque.
![Vagrantfile](img/app-js.png);
El contenido de este archivo es proporcionado en el pdf.

De momento nuestro bootstrap.sh quedaría así: 
![Vagrantfile](img/bootstrap-v1.png);

Y ahora cuando nos metemos en la dirección `192.168.56.10:3000` podemos ver que nos está lanzando el archivo `app.js` que hemos creado, vemremos la pantalla de `Hello World!`.
![Vagrantfile](img/hello-world.png);

Ahora vamos a empezar con las pruebas propuestas en el pdf, ya que como dice, tenemos dos rutas, una es la que devuelve el hello world y la otra es la de la API, a la cual le tenemos que pasar diferentes números como parámetros, para ver los resultados devueltos.

Prueba 1 con valor de n = 50:
![Vagrantfile](img/prueba-1.png);
Como vemos tiene una respueta muy rápida

Prueba 2 con valor de n = 5000000000:
![Vagrantfile](img/prueba-2.png);