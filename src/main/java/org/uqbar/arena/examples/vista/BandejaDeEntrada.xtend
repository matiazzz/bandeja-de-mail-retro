package org.uqbar.arena.examples.vista

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.examples.dominio.Usuario
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.examples.dominio.Mail
import java.util.List
import org.uqbar.arena.examples.dominio.appModel.BandejaDeEntradaAppModel

class BandejaDeEntrada extends SimpleWindow<BandejaDeEntradaAppModel>{
	
	new(WindowOwner parent, Usuario usuario, List<Usuario> usuarios){
		super(parent, new BandejaDeEntradaAppModel(usuario, usuarios))
	}
	
	override protected addActions(Panel accionesPanel) {
		new Button(accionesPanel) =>[
			caption = "Enviar"
			onClick [this.modelObject.enviarMail ]
			bindEnabledToProperty("mail.mailValido")
		]
		
		new Button(accionesPanel) =>[
			caption = "Borrar"
			onClick [ this.modelObject.borrar]
		]
	}
	
	override protected createFormPanel(Panel parent) {
		
		new Label(parent).text = '''Hola «modelObject.usuario.nombre.toFirstUpper»!'''
		new Label(parent).bindValueToProperty("usuario.cantidadDeMensajes")
		parent.layout = new VerticalLayout
		new Label(parent)=> [
			text = "Bandeja de Entrada"
			fontSize = 20
		]
		
		val bandejaDeEntrada = new Table<Mail>(parent,Mail)
		bandejaDeEntrada.bindItemsToProperty("usuario.bandejaDeEntrada")
		new Column<Mail>(bandejaDeEntrada) => [
			title = "De"
			bindContentsToProperty("from.nombre")
		]
		
		new Column<Mail>(bandejaDeEntrada) => [
			title = "Asunto"
			bindContentsToProperty("subject")
		]
		
		new Column<Mail>(bandejaDeEntrada) => [
			title = "Contenido"
			bindContentsToProperty("body")
		]
		
		new Label(parent)=> [
			text = "Enviar Mail"
			fontSize = 20
		]
		
		new Label(parent).text = "Destinatario"
		new Selector(parent) => [
			bindValueToProperty("mail.to")
			bindItemsToProperty("destinatariosPosibles").adapter = new PropertyAdapter(Usuario, "nombre")
		]
		
		new Label(parent).text = "Asunto"
		new TextBox(parent).bindValueToProperty("mail.subject")
		
		new Label(parent).text = "Mensaje"
		new TextBox(parent) => [
			bindValueToProperty("mail.body")
			multiLine = true
		]
		
	}
	
}