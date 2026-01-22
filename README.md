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
En este segundo caso, como vemos, el tiempo de respuesta es bastante más grande, llegando a tardar hasta 16 segundos.

### 2.2 ¡Ahora con más clúster!
Lo primero que tenemos que hacer ahora es modificar el archivo de `app.js`, siendo de nuevo el dado en la práctica.
![Vagrantfile](img/app-js-2.png);

Vamos a ver como afecta esto a los mismos dos casos que hemos realizado anteriormente, pero antes tenemos que realizar un `vagrant reload` para que los cambios se apliquen.

Después de unos cuantos errores, he visto que tengo que cambiar una línea para que funcione, y es la siguiente;
![Vagrantfile](img/app-js-cambio.png);

Y además añadir `config.vm.network "forwarded_port", guest: 3000, host: 3000` al archivo `Vagrantfile` para que nos permita acceder a la aplicación desde el host.

Cuando vuelve a funcionar la aplicación, vamos a ver los resultados de las pruebas que hemos mencionado antes.

Prueba 1 con valor de n = 50:
![Vagrantfile](img/prueba-1-2.png);

Prueba 2 con valor de n = 5000000000:
![Vagrantfile](img/prueba-2-2.png);

Como podemos ver los tiempos han bajado, y la respuesta es más rápida.
Pero para esto he tenido que especificarle a la máquina que use 4 nucleos: 
![Vagrantfile](img/cpus.png);

Por tanto, como es algo obvio, el rendimiento aumentará con más nucleos.

## 3. Métricas de rendimiento

Vamos a instalar un programa llamado `loadtest` para realizar las pruebas de rendimiento, ya que este nos permite realizar simular una gran cantidad de conexiones.
Para la instalación, vamos a usar el comando `npm install -g loadtest`.

Ahora abrimos una nueva terminal y lanzamos la prueba: 
![Vagrantfile](img/loadtest.png);

Ahora vamos a ir lanzando diferentes pruebas, para ver como se comportan los resultados.
La siguiente prueba es sin clúster.
Para esto tenemos que poner el primer codigo para `app.js` que hemos utilizado, y luego volver a lanzar la maquína para después hacer la prueba correspondiente.
![Vagrantfile](img/loadtest-1.png);

Como podemos ver, la respuesta es mas lenta, ya que al quitarle los clústers, el tiempo de respuesta aumenta.

La conclusión que sacamos es que los clusters son muy útiles para manejar una mayor cantidad de peticiones por segunda y con una menor latencia.

## 4. Uso de PM2 para administrar un clúster de Node.js

Para esta parte necesitamos instalar `pm2`, este nos facilita la parada, eliminación de procesos, y no solo eso, disponemos de algunas herramientas de monitorización.

Vamos usar el comando de instalación: `npm install -g pm2`.

Y como indica la actividad vamos a usar la versión que no está clusterizada.

Vamos a añadir a bootstrap.sh el comando de `pm2 start app.js -i 0`, con el -i le vamos a indicar a la aplicación que se inicie en cluster_mode. Y cone el 0 le decimos que genere automáticamente tantos workers como nucleos tengamos.

Una vez lanzamos vamos a ver por terminal lo siguiente:
![Vagrantfile](img/pm2.png);

Cuando ya no queramos tener la aplicación encendida, simplemtente ejecutamosa el comando `pm2 stop app.js` esto va a hacer que la aplicación se detenga y muestre por la terminar todos los procesos con un estado de `stopped`.
![Vagrantfile](img/pm2-stop.png);

Vamos a volver a lanzar el comando `pm2 start app.js -i 0` y luego el `pm2 ecosystem` para de esta forma crear el archivo Ecosystem. Este archivo se llama ecosystem.config.js y para el caso de nuestra aplicación lo tenemos que modificar con el contenido propuesto en el pdf.
![Vagrantfile](img/pm2-ecosystem-comando.png);

Para modificar el archivo tenemosq que hacer un `sudo nano ecosystem.config.js` y luego modificar el contenido de la siguiente manera:
![Vagrantfile](img/pm2-ecosystem.png);

Y luego lanzar el comando `pm2 start ecosystem.config.js` para que se lance la aplicación.
Aquí podemos ver el estado de la aplicación y ver como efectivamente se está ejecutando en modo clúster.

Vamos a ver los resultados de los comandos propuestos en el pdf.
1. pm2 ls
![Vagrantfile](img/pm2-ls.png);

2. pm2 logs
![Vagrantfile](img/pm2-logs.png);

3. pm2 monit
![Vagrantfile](img/pm2-monit.png);

## 5. Cuestiones

Hay que pensar que le clúster esta diseñado para mejorar la disponibilidad de la aplicación y el rendimiento bajo estrés de esta. Pero el coste de manterner la infraestrucutra del clúster supera los beneficios de hacer las respuestas paralelas, en resumen, para tareas pequeñas es mejor no tener un clúster y por esto son mejores las que estan sin clusterizar, pero ojo solo para peticiones pequeñas. Cuando tenemos ya una gran cantidad de peticiones tener un clúster es inmensamente útil a pesar del coste de mantener la infraestructura.