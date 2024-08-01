<template>
  <div class="GET">
    <form class="form" action="">
      <p type="INSERTAR UN AUTOR:"></p>
      <p type="Nombre: ">
        <input v-model="nombre" type="text" />
      </p>
      <p type="Apellido: ">
        <input v-model="apellido" type="text" />
      </p>

      <button @click="insertar">Ingresar</button>
    </form>

    <form class="form" action="">
      <p type="BUSCAR POR ID:">
        <button @click="buscar">BUSCAR</button>
        <input v-model="id" type="text" />
      </p>

      <p type="Nombre: ">
        <input v-model="body.nombre" type="text" />
      </p>
      <p type="Apellido: ">
        <input v-model="body.apellido" type="text" />
      </p>
    </form>
  </div>
  <div>
    <button @click="consultar">CONSULTAR TODOS</button>

    <table>
      <tr>
        <td>Nombre</td>
        <td>Apellido</td>
        <td>Eliminar Cliente</td>
      </tr>
      <tr v-for="dato in datos" :key="dato.id">
        <td>{{ dato.nombre }}</td>
        <td>{{ dato.apellido }}</td>
        <td  v-if="datosCargados"><button @click="eliminarAutor(dato.id)">Eliminar</button></td>
      </tr>
    </table>
  </div>
</template>

<script>
import {
  insertarfachada,
  consultarFachada,
  buscarFachadaf,
  eliminarFachada,
} from "../helpers/clienteAuthor";
export default {
  data() {
    return {
      id: null,
      body: {
        type: Object,
        requerid: false,
      },
      nombre: null,
      apellido: null,
      direccion: null,
      datos: {
        type: Object,
        requerid: false,
      },
      datosCargados: false,
    };
  },
  methods: {
    async insertar() {
      if (this.nombre && this.apellido ) {
        const pacBody = {
          nombre: this.nombre,
          apellido: this.apellido,
        };
        console.log(pacBody)
        await insertarfachada(pacBody);
        alert("SE A REGISTRADO CORRECTAMENTE");
      }
    },
    async buscar() {
      if (this.id) {
        const data = await buscarFachadaf(this.id);
        if (data) {
          this.body.nombre = data.nombre;
          this.body.apellido = data.apellido;
          this.body.direccion = data.direccion;
        } else {
          console.error("No se encontró el cliente con el ID proporcionado.");
        }
      } else {
        console.error("Por favor, proporciona un ID.");
      }
    },
    async consultar() {
      const datos = await consultarFachada();
      console.log(datos);
      this.datos = datos;
      console.log(this.datos);
      this.datosCargados = true;
    },
    async eliminarAutor(id) {
      // Lógica para eliminar la consulta con el ID correspondiente
      await eliminarFachada(id);
      location.reload();
    },
  },
};
</script>

<style scoped>
  
.GET {
  display: grid;
  align-content: center;
  justify-content: center;
  padding-block-start: 20px;
}
.POST {
  display: grid;
  align-content: center;
  justify-content: center;
}
form {
  width: 340px;
  height: 250px;
  background-color: #1e4f75;
  border-radius: 8px;
  padding: 10px 30px;
  margin: 5px;
  font-family: "Times New Roman", Times, serif;
  box-shadow: 0px 0px 40px -10px #000;
}

p:before {
  content: attr(type);
  display: block;
  margin: 3px 2px;
  font-size: 16px;
  color: #fffdfd;
}
button {
  margin: 10px;
}
#id {
  margin-left: 150px;
  width: 100px;
}
#titulo2 {
  margin-bottom: 50px;
}
table {
  margin: 0px 20px;
  background: -webkit-linear-gradient(left, #25c481, rgb(56, 119, 160));
  background: linear-gradient(to right, #25c481, rgb(56, 119, 160));
  text-align: left;
  width: 100%;
  height: 100%;
  table-layout: fixed;
}
.tablah {
  padding: 5px;
  padding-right: 60px;
  margin: 20px;
  border-radius: 10px;
  background-color: #007c76;
  box-shadow: 15px 10px 5px 5px #00000033;
}

th {
  padding: 20px 15px;
  text-align: left;
  font-weight: 500;
  font-size: 12px;
  color: #fff;
  text-transform: uppercase;
}
td {
  padding: 15px;
  text-align: left;
  vertical-align: middle;
  font-weight: 300;
  font-size: 12px;
  color: #fff;
  border-bottom: solid 1px rgba(255, 255, 255, 0.1);
}
</style>