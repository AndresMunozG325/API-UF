class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  # GET /clients
  def index
    @clients = Client.all

    render json: @clients
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  def consult_uf
    api_address = "https://mindicador.cl/api/uf/#{(params[:date])}"
    response = HTTParty.get(api_address)
    
    converthash = JSON.parse(response.read_body)
    
    if converthash['serie'][0].nil?
      return render json: {mensaje:"No existen datos para la fecha indicada"}
    else 
      
      if request.headers['x-CLIENTE'].present?
        Client.create(name: request.headers['X-CLIENTE'], r_date: "#{params[:date]}", v_uf: converthash['serie'][0]['valor'] )
        render json: converthash['serie'][0]['valor']
      else
        return render json: {mensaje:"Indicar KEY = X-CLIENTE  en HEADER nombre de cliente"}
      end
    end
  end

  def my_queries
    name = params[:name]
    detalle = []
    (Client.where(name: name)).each do |c|
      datos = {}
      datos[:r_date] = c.r_date
      datos[:v_uf] = c.v_uf
      detalle.push(datos)
    end
    muestra_datos = {"Cantidad de consultas": "#{Client.where(name: name).count}", "Detalle de consultas": "#{detalle}"}
    render json: muestra_datos
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.require(:client).permit(:name, :r_date, :v_uf)
    end
end
