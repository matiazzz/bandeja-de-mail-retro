package org.uqbar.arena.examples.dominio

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils

@Observable
@Accessors
class Mail {
	
	Usuario from
	Usuario to
	String subject
	String body

	new() {
	}
	
	new (Usuario from, Usuario to, String subject, String body){
		this.from = from
		this.to = to
		this.subject = subject
		this.body = body
	}
	
	def void setTo(Usuario to){
		this.to = to
		ObservableUtils.firePropertyChanged(this, "mailValido", mailValido)
	}
	
	def void setBody(String body){
		this.body = body
		ObservableUtils.firePropertyChanged(this, "mailValido", mailValido)
	}
	
	def void setSubject(String subject){
		this.subject = subject
		ObservableUtils.firePropertyChanged(this, "mailValido", mailValido)
	}
	
	def mailValido(){
		body.isValido &&
		subject.isValido &&
		to != null
	}
	
	def isValido(String string) {
		string != null && string != ""
	}
	
}