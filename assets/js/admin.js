/**
 * panel de administración: CRUD de productos (api/productos.php) y gestión
 * de usuarios y roles (api/auth.php). Solo funciona si el usuario es admin;
 * el servidor vuelve a comprobarlo en cada acción
 */
(() => {
  const AUTH = '../api/auth.php', PROD = '../api/productos.php';
  const $ = (id) => document.getElementById(id);
  let miId = 0;

  const aviso = (t, err) => { $('admMsg').textContent = t; $('admMsg').className = 'adm__msg' + (err ? ' err' : ''); };
  const celda = (tr, txt) => { const td = document.createElement('td'); td.textContent = txt; tr.appendChild(td); return td; };
  const boton = (txt, fn) => { const b = document.createElement('button'); b.type = 'button'; b.className = 'b'; b.textContent = txt; b.addEventListener('click', fn); return b; };

  async function api(url, cuerpo) {
    const r = await fetch(url, cuerpo ? { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(cuerpo) } : undefined);
    const d = await r.json();
    if (!d.ok) throw new Error(d.error || 'Error del servidor.');
    return d;
  }

  /* ---------- productos ---------- */
  function pintarProductos(lista) {
    const tb = $('tbProd'); tb.textContent = '';
    lista.forEach((p) => {
      const tr = document.createElement('tr');
      celda(tr, p.id); celda(tr, p.nombre); celda(tr, p.tipo); celda(tr, p.precio);
      const acc = document.createElement('td');
      acc.append(boton('Editar', () => editar(p)), ' ', boton('Eliminar', async () => {
        if (!confirm('¿Eliminar "' + p.nombre + '"? También saldrá de los carritos.')) return;
        try { pintarProductos((await api(PROD, { accion: 'eliminar', id: p.id })).productos); aviso('Producto eliminado.'); }
        catch (e) { aviso(e.message, true); }
      }));
      tr.appendChild(acc); tb.appendChild(tr);
    });
  }
  function pintarFotos(p) {
    const caja = $('pFotos');
    const lista = $('pFotosLista');
    lista.textContent = '';
    if (!p || !Number(p.id)) { caja.hidden = true; return; }
    caja.hidden = false;

    for (let posicion = 1; posicion <= 4; posicion++) {
      const tarjeta = document.createElement('div');
      tarjeta.className = 'adm__foto';
      const ruta = (p.imagenes || [])[posicion - 1];
      if (ruta) {
        const img = document.createElement('img');
        img.src = ruta;
        img.alt = 'Foto ' + posicion + ' de ' + p.nombre;
        tarjeta.appendChild(img);
      } else {
        const vacia = document.createElement('div');
        vacia.className = 'adm__foto-vacia';
        vacia.textContent = 'Sin foto';
        tarjeta.appendChild(vacia);
      }

      const titulo = document.createElement('strong');
      titulo.textContent = 'Foto ' + posicion;
      tarjeta.appendChild(titulo);
      const input = document.createElement('input');
      input.type = 'file';
      input.accept = 'image/jpeg,image/png,image/webp';
      input.setAttribute('aria-label', 'Cambiar foto ' + posicion);
      input.addEventListener('change', async () => {
        const archivo = input.files && input.files[0];
        if (!archivo) return;
        if (archivo.size > 5 * 1024 * 1024) {
          aviso('La foto debe pesar máximo 5 MB.', true);
          input.value = '';
          return;
        }
        const datos = new FormData();
        datos.append('accion', 'subir_imagen');
        datos.append('id', String(p.id));
        datos.append('posicion', String(posicion));
        datos.append('imagen', archivo);
        input.disabled = true;
        try {
          const respuesta = await fetch(PROD, { method: 'POST', body: datos });
          const resultado = await respuesta.json();
          if (!resultado.ok) throw new Error(resultado.error || 'No se pudo subir la foto.');
          const actualizado = resultado.productos.find((producto) => Number(producto.id) === Number(p.id));
          pintarProductos(resultado.productos);
          if (actualizado) editar(actualizado);
          aviso('Foto actualizada.');
        } catch (error) {
          aviso(error.message, true);
        } finally {
          input.disabled = false;
          input.value = '';
        }
      });
      tarjeta.appendChild(input);
      lista.appendChild(tarjeta);
    }
  }

  function editar(p) {
    $('pId').value = p.id; $('pNombre').value = p.nombre; $('pTipo').value = p.tipo;
    $('pDesc').value = p.descripcion; $('pPrecio').value = p.precio_valor;
    $('pGuardar').textContent = 'Guardar cambios'; $('pCancelar').hidden = false;
    pintarFotos(p);
    $('pNombre').focus();
  }
  function limpiar() {
    $('formProd').reset(); $('pId').value = '';
    $('pGuardar').textContent = 'Crear producto'; $('pCancelar').hidden = true;
    $('pFotos').hidden = true; $('pFotosLista').textContent = '';
  }
  $('pCancelar').addEventListener('click', limpiar);
  $('formProd').addEventListener('submit', async (e) => {
    e.preventDefault();
    const id = Number($('pId').value);
    const datos = { accion: id ? 'actualizar' : 'crear', id, nombre: $('pNombre').value, tipo: $('pTipo').value,
                    descripcion: $('pDesc').value, precio: Number($('pPrecio').value) };
    try { pintarProductos((await api(PROD, datos)).productos); aviso(id ? 'Producto actualizado.' : 'Producto creado.'); limpiar(); }
    catch (er) { aviso(er.message, true); }
  });

  /* ---------- usuarios ---------- */
  async function cargarUsuarios() {
    const tb = $('tbUsu');
    try {
      const { usuarios } = await api(AUTH + '?accion=usuarios');
      tb.textContent = '';
      usuarios.forEach((u) => {
        const tr = document.createElement('tr');
        celda(tr, u.id); celda(tr, u.nombre); celda(tr, u.correo); celda(tr, u.rol);
        const acc = document.createElement('td');
        if (Number(u.id) !== miId) {
          const nuevo = u.rol === 'admin' ? 'usuario' : 'admin';
          acc.append(boton('Hacer ' + nuevo, async () => {
            try { await api(AUTH, { accion: 'cambiar_rol', id: Number(u.id), rol: nuevo }); aviso('Rol actualizado.'); cargarUsuarios(); }
            catch (e) { aviso(e.message, true); }
          }), ' ', boton('Eliminar', async () => {
            if (!confirm('¿Eliminar la cuenta de ' + u.correo + '? Se borran sus datos.')) return;
            try { await api(AUTH, { accion: 'eliminar_usuario', id: Number(u.id) }); aviso('Usuario eliminado.'); cargarUsuarios(); }
            catch (e) { aviso(e.message, true); }
          }));
        } else acc.textContent = '(tú)';
        tr.appendChild(acc); tb.appendChild(tr);
      });
    } catch (e) { aviso(e.message, true); }
  }

  /* ---------- pestañas y arranque ---------- */
  function pestana(prod) {
    $('secProd').hidden = !prod; $('secUsu').hidden = prod;
    $('tabProd').classList.toggle('on', prod); $('tabUsu').classList.toggle('on', !prod);
    if (!prod) cargarUsuarios();
  }
  $('tabProd').addEventListener('click', () => pestana(true));
  $('tabUsu').addEventListener('click', () => pestana(false));

  (async () => {
    try {
      const s = await api(AUTH + '?accion=sesion');
      if (!s.usuario) { $('admEstado').textContent = 'Inicia sesión para continuar.'; return; }
      if (s.usuario.rol !== 'admin') { $('admEstado').textContent = 'Esta página es solo para administradores.'; return; }
      miId = s.usuario.id;
      $('admEstado').textContent = 'Sesión: ' + s.usuario.nombre;
      $('admPanel').hidden = false;
      pintarProductos((await api(PROD)).productos);
    } catch (e) { $('admEstado').textContent = e.message; }
  })();
})();
