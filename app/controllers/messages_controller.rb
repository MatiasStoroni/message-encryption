class MessagesController < ApplicationController

  #lista que contiene todas las letras del alfabeto
  ALFABETO = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  before_action :set_message, only: [:update, :destroy]

  def create
    message = Message.create(message_params)
    respond_to do |format|
      if message.errors.blank?
        format.json { render status: 200, json: message }
      else
        format.json { render status: 400, json: { message: message.errors.full_messages } }
      end
    end
  end

  def update
    respond_to do |format|
      if @Message.update(message_params)
        format.json { render status: 200, json: @Message }
      else
        format.json { render status: 400, json: { message: @Message.errors.full_messages } }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @Message.destroy
        format.json { render status: 200, json: @Message }
      else
        format.json { render status: 400, json: { message: @Message.errors.full_messages } }
      end
    end
  end

  def encrypt
    message = Message.find_by(id: params[:message_id])

    if message.encrypted
      render json: "El mensaje ya ha sido encriptado", status: 405
      return
    end

    ####Elminar espacios y pasar todo a mayusculas
    text = message.body
    text = text.delete(" ")
    text = text.upcase
    ########

    key = message.key
    n = key.length

    #variable que recorre las posiciones de la clave de cifrado
    key_position = 0
    for i in 0..(text.length - 1)

      #obtengo la posicion de la letra y le calculo su nueva posicion con el desplazamiento
      letter_position = ALFABETO.index(text[i])
      shift = key[key_position].to_i
      new_position = letter_position + shift

      #para evitar el overflow del arreglo ALFABETO
      if new_position > 26
        new_position = (new_position - 27)
      end

      #obtengo la nueva letra y la reemplazo en el texto
      shifted_letter = ALFABETO[new_position]
      text[i] = shifted_letter

      #me permite iterar sobre la cadena de la clave de cifrado sin que haya overflow
      if (key_position == (n - 1))
        key_position = 0
      else
        key_position += 1
      end
    end

    message.update(body: text, encrypted: true)

    render json: message, status: 200
  end

  private

  def set_message
    @Message = Message.find_by(id: params[:id])

    return if @Message.present?

    respond_to do |format|
      format.json { render status: 400, json: :no_exist }
    end
  end

  def message_params
    params.permit(:body, :key, :encrypted)
  end
end
