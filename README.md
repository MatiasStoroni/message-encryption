# message-encryption
En este repositorio se observa una API REST hecha en RubyOnRails, la cual tiene un modelo y un controlador para el manejo de entidades "**Message**".

El funcionamiento de la misma consiste en la creación de un mensaje a partir de un método **POST** con la ruta **"/messages"**. Dicho mensaje contiene el texto del mensaje junto con una clave, que se utilizará posteriormente para realizar el cifrado.

Una vez creado el mensaje se puede pasar al cifrado, usando un método **PUT** a la ruta **"/messages/:message_id/encriptar"**. Esta ruta invoca la función "**encrypt**" dentro del controlador de mensajes. La función tomará los atributos ya mencionados del mensaje para llevar a cabo el algoritmo de cifrado.
Este proceso modifica la entidad "**Message**" original y cambia el contenido del texto por el nuevo mensaje cifrado.

A continuación se indica la ubicación de los archivos más relevantes:
  - El código de la función puede encontrarse en **"app\controllers\messages_controller.rb"**
  - Las principales rutas están en **"config\routes.rb"**
  - Las validaciones de los atributos del modelo se indican en **"app\models\message.rb"**
  - La estructura de la clase "**Message**" está en **"db\migrate\20231205220228_create_messages.rb"**

En caso de querer ejecutar el código localmente, se debe abrir la ubicación del proyecto en una terminal y ejecutar el commando "rails server" para correr un servidor local que permita probar las funcionalidades de la API.

**Versiones**
  - ruby 3.2.2
  - rails 7.0.8
